"use client";

import { useEffect, useState } from "react";
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  LinearScale,
  TimeScale,
  Tooltip,
  Legend,
  CategoryScale,
} from "chart.js";
import { Line } from "react-chartjs-2";

ChartJS.register(
  LineElement,
  PointElement,
  LinearScale,
  TimeScale,
  Tooltip,
  Legend,
  CategoryScale
);

interface Props {
  id: string;
}

export default function CoinChart({ id }: Props) {
  const [chartData, setChartData] = useState<any>(null);

  useEffect(() => {
  const fetchChart = async () => {
    try {
      const res = await fetch(`/api/coins/${id}/history`);

      if (!res.ok) {
        console.error("Chart fetch failed:", res.status);
        return;
      }

      const data = await res.json();

      if (!data?.prices) {
        console.error("Invalid chart data:", data);
        return;
      }

      const labels = data.prices.map((p: number[]) =>
        new Date(p[0]).toLocaleDateString()
      );

      const values = data.prices.map((p: number[]) => p[1]);

      setChartData({
        labels,
        datasets: [
          {
            label: "Price (USD)",
            data: values,
            borderColor: "#0149e6ff",
            backgroundColor: "rgba(11, 37, 49, 0.2)",
            tension: 0.3,
            fill: true,
          },
        ],
      });
    } catch (error) {
      console.error("Chart error:", error);
    }
  };

  fetchChart();
}, [id]);

  if (!chartData) return <p>Loading chart...</p>;

  return (
    <div className="w-full">
      <Line data={chartData} />
    </div>
  );
}
