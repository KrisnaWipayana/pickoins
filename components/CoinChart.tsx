"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import {
  Chart as ChartJS,
  LinearScale,
  TimeScale,
  Tooltip,
} from "chart.js";
import {
  CandlestickController,
  CandlestickElement,
} from "chartjs-chart-financial";
import "chartjs-adapter-date-fns";
import { Chart } from "react-chartjs-2";

ChartJS.register(
  LinearScale,
  TimeScale,
  Tooltip,
  CandlestickController,
  CandlestickElement
);

interface Props {
  id: string;
}

type Range = "1m" | "5m" | "15m" | "1h" | "4h" | "1d";

type Candle = {
  x: number;
  o: number;
  h: number;
  l: number;
  c: number;
};

const symbolMap: Record<string, string> = {
  bitcoin: "BTCUSDT",
  ethereum: "ETHUSDT",
  solana: "SOLUSDT",
};

const LIVE_ANIMATION_DURATION = 150;

export default function CoinChart({ id }: Props) {
  const [candles, setCandles] = useState<Candle[]>([]);
  const [range, setRange] = useState<Range>("5m");
  const [isLoading, setIsLoading] = useState(true);
  const [zoomReady, setZoomReady] = useState(false);

  const chartRef = useRef<ChartJS | null>(null);
  const socketRef = useRef<WebSocket | null>(null);
  const reconnectRef = useRef<NodeJS.Timeout | null>(null);
  const fetchAbortRef = useRef<AbortController | null>(null);
  const candleBufferRef = useRef<Candle[]>([]);

  const symbol = symbolMap[id];
  const interval = range;

  useEffect(() => {
    import("chartjs-plugin-zoom").then((mod) => {
      ChartJS.register(mod.default);
      setZoomReady(true);
    });
  }, []);

  useEffect(() => {
    if (!symbol) return;

    fetchAbortRef.current?.abort();
    const controller = new AbortController();
    fetchAbortRef.current = controller;

    setIsLoading(true);
    setCandles([]);
    candleBufferRef.current = [];

    const fetchInitial = async () => {
      try {
        const res = await fetch(
          `https://api.binance.com/api/v3/klines?symbol=${symbol}&interval=${interval}&limit=200`,
          { signal: controller.signal }
        );

        if (!res.ok) return;

        const data = await res.json();

        const formatted: Candle[] = data.map((c: any) => ({
          x: c[0],
          o: parseFloat(c[1]),
          h: parseFloat(c[2]),
          l: parseFloat(c[3]),
          c: parseFloat(c[4]),
        }));

        candleBufferRef.current = formatted;
        setCandles(formatted);
      } catch (err: any) {
        if (err.name !== "AbortError") {
          console.error("Initial fetch error:", err);
        }
      } finally {
        setIsLoading(false);
      }
    };

    fetchInitial();

    return () => {
      controller.abort();
    };
  }, [symbol, interval]);

  useEffect(() => {
    if (!symbol || !interval) return;

    const closeSocket = () => {
      if (socketRef.current) {
        socketRef.current.onclose = null;
        socketRef.current.onerror = null;
        socketRef.current.close();
        socketRef.current = null;
      }
      if (reconnectRef.current) {
        clearTimeout(reconnectRef.current);
        reconnectRef.current = null;
      }
    };

    closeSocket();

    let destroyed = false;

    const connect = () => {
      if (destroyed) return;

      const ws = new WebSocket(
        `wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@kline_${interval}`
      );

      socketRef.current = ws;

      ws.onmessage = (event) => {
        if (destroyed) return;

        const { k } = JSON.parse(event.data);

        const newCandle: Candle = {
          x: k.t,
          o: parseFloat(k.o),
          h: parseFloat(k.h),
          l: parseFloat(k.l),
          c: parseFloat(k.c),
        };

        const buffer = candleBufferRef.current;
        if (!buffer.length) return;

        const last = buffer[buffer.length - 1];
        const chart = chartRef.current;

        if (last.x === newCandle.x) {
          buffer[buffer.length - 1] = newCandle;

          if (chart) {
            (chart.data.datasets[0].data as Candle[])[buffer.length - 1] = newCandle;
            chart.options.animation = {
              duration: LIVE_ANIMATION_DURATION,
              easing: "easeOutQuart",
            } as any;
            chart.update("active");
          }
        } else if (k.x) {
          buffer.push(newCandle);
          if (buffer.length > 200) buffer.shift();

          if (chart) {
            (chart.data.datasets[0].data as Candle[]).push(newCandle);
            if ((chart.data.datasets[0].data as Candle[]).length > 200) {
              (chart.data.datasets[0].data as Candle[]).shift();
            }
            chart.options.animation = {
              duration: LIVE_ANIMATION_DURATION,
              easing: "easeOutQuart",
            } as any;
            chart.update("active");
          }
        }
      };

      ws.onclose = () => {
        if (!destroyed) {
          reconnectRef.current = setTimeout(connect, 3000);
        }
      };

      ws.onerror = () => ws.close();
    };

    connect();

    return () => {
      destroyed = true;
      closeSocket();
    };
  }, [symbol, interval]);

  const chartData = useMemo(() => ({
    datasets: [
      {
        label: symbol,
        data: [...candles],
        color: {
          up: "#22c55e",
          down: "#ef4444",
          unchanged: "#64748b",
        },
      },
    ],
  }), [candles, symbol]);

  const chartOptions = useMemo(() => ({
    responsive: true,
    maintainAspectRatio: false,
    animation: false as const,
    plugins: {
      legend: { display: false },
      tooltip: {
        backgroundColor: "#0f172a",
        callbacks: {
          label: (ctx: any) => {
            const d = ctx.raw;
            return `O: ${d.o}  H: ${d.h}  L: ${d.l}  C: ${d.c}`;
          },
        },
      },
      zoom: {
        pan: {
          enabled: true,
          mode: "x" as const,
        },
        zoom: {
          wheel: {
            enabled: true,
            speed: 0.02,
          },
          pinch: {
            enabled: true,
          },
          mode: "x" as const,
        },
        limits: {
          x: { minRange: 5 * 60 * 1000 },
        },
      },
    },
    scales: {
      x: {
        type: "time" as const,
        grid: { display: false },
        ticks: { color: "#94a3b8" },
      },
      y: {
        position: "right" as const,
        grid: { color: "rgba(148,163,184,0.05)" },
        ticks: { color: "#94a3b8" },
      },
    },
  }), []);

  const showChart = !isLoading && candles.length > 0 && zoomReady;

  return (
    <div className="w-full">
      {/* Timeframe Selector */}
      <div className="flex gap-2 mb-4">
        {(["1m", "5m", "15m", "1h", "4h", "1d"] as Range[]).map((r) => (
          <button
            key={r}
            onClick={() => setRange(r)}
            className={`px-3 py-1 text-sm rounded-md transition ${
              range === r
                ? "bg-amber-500 text-white"
                : "bg-slate-800 text-slate-400 hover:bg-slate-700"
            }`}
          >
            {r}
          </button>
        ))}
      </div>

      <div className="relative h-[400px]">
        {!showChart && (
          <div className="absolute inset-0 flex items-center justify-center z-10 bg-slate-900/60 rounded-md">
            <p className="text-slate-400 text-sm">Loading {symbol}…</p>
          </div>
        )}

        {showChart && (
          <Chart
            key={`${symbol}-${interval}`}
            ref={chartRef as any}
            type="candlestick"
            data={chartData}
            options={chartOptions}
          />
        )}
      </div>
    </div>
  );
}