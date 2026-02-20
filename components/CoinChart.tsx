"use client";

import { useEffect, useMemo, useState } from "react";
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Tooltip,
  Filler,
} from "chart.js";
import { Line } from "react-chartjs-2";

ChartJS.register(
  LineElement,
  PointElement,
  LinearScale,
  CategoryScale,
  Tooltip,
  Filler
);

interface Props {
  id: string;
}

type StyleMode = "auto" | "blue" | "green" | "red";
type Range = "1" | "7" | "30" | "90" | "365";

export default function CoinChart({ id }: Props) {
  const [prices, setPrices] = useState<number[]>([]);
  const [labels, setLabels] = useState<string[]>([]);
  const [styleMode, setStyleMode] = useState<StyleMode>("auto");
  const [range, setRange] = useState<Range>("7");

  useEffect(() => {
    const fetchChart = async () => {
      const res = await fetch(
        `/api/coins/${id}/history?days=${range}`
      );
      if (!res.ok) return;

      const data = await res.json();
      if (!data?.prices) return;

      const l = data.prices.map((p: number[]) => {
        const date = new Date(p[0]);

        // jika 1 hari → tampilkan jam
        if (range === "1") {
          return date.toLocaleTimeString([], {
            hour: "2-digit",
            minute: "2-digit",
          });
        }

        return date.toLocaleDateString();
      });

      const v = data.prices.map((p: number[]) => p[1]);

      setLabels(l);
      setPrices(v);
    };

    fetchChart();
  }, [id, range]);

  const trendUp = useMemo(() => {
    if (prices.length < 2) return true;
    return prices[prices.length - 1] >= prices[0];
  }, [prices]);

  const resolvedColor = useMemo(() => {
    if (styleMode === "blue") return "#3b82f6";
    if (styleMode === "green") return "#22c55e";
    if (styleMode === "red") return "#ef4444";
    return trendUp ? "#22c55e" : "#ef4444";
  }, [styleMode, trendUp]);

  const chartData = useMemo(() => {
    if (!prices.length) return null;

    return {
      labels,
      datasets: [
        {
          data: prices,
          borderColor: resolvedColor,
          borderWidth: 2,
          tension: 0.4,
          pointRadius: 0,
          fill: true,
          backgroundColor: (context: any) => {
            const ctx = context.chart.ctx;
            const gradient = ctx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, `${resolvedColor}40`);
            gradient.addColorStop(1, `${resolvedColor}00`);
            return gradient;
          },
        },
      ],
    };
  }, [prices, labels, resolvedColor]);

  if (!chartData) return <p className="text-slate-400">Loading...</p>;

  return (
    <div className="w-full">
      {/* Controls */}
      <div className="flex justify-between items-center mb-4">
        {/* Range Selector */}
        <div className="flex gap-2">
          {[
            { label: "1D", value: "1" },
            { label: "7D", value: "7" },
            { label: "30D", value: "30" },
            { label: "90D", value: "90" },
            { label: "1Y", value: "365" },
          ].map((r) => (
            <button
              key={r.value}
              onClick={() => setRange(r.value as Range)}
              className={`px-3 py-1 text-sm rounded-md transition ${range === r.value
                  ? "bg-blue-600 text-white"
                  : "bg-slate-800 text-slate-400 hover:bg-slate-700"
                }`}
            >
              {r.label}
            </button>
          ))}
        </div>

        {/* Style Selector */}
        <select
          value={styleMode}
          onChange={(e) =>
            setStyleMode(e.target.value as StyleMode)
          }
          className="bg-slate-800 text-sm px-3 py-1 rounded-md border border-slate-700"
        >
          <option value="auto">Auto</option>
          <option value="blue">Blue</option>
          <option value="green">Green</option>
          <option value="red">Red</option>
        </select>
      </div>

      <div className="h-[350px]">
        <Line
          data={chartData}
          options={{
            responsive: true,
            maintainAspectRatio: false,
            animation: {
              duration: 800,
            },
            plugins: {
              legend: { display: false },
              tooltip: {
                backgroundColor: "#0f172a",
                displayColors: false,
                callbacks: {
                  label: (context) => {
                    const value = context.parsed.y;
                    if (value == null) return "";
                    return `$${value.toLocaleString()}`;
                  },
                },
              },
            },
            scales: {
              x: {
                grid: { display: false },
                ticks: {
                  color: "#64748b",
                  maxTicksLimit: 6,
                },
                border: { display: false },
              },
              y: {
                grid: {
                  color: "rgba(148,163,184,0.05)",
                },
                ticks: {
                  color: "#64748b",
                  callback: (value) =>
                    `$${Number(value).toLocaleString()}`,
                },
                border: { display: false },
              },
            },
          }}
        />
      </div>
    </div>
  );
}