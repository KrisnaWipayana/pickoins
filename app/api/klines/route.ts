import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  const { searchParams } = new URL(req.url);

  const symbol = searchParams.get("symbol");
  const interval = searchParams.get("interval");
  const limit = searchParams.get("limit") ?? "200";

  const res = await fetch(
    `https://data-api.binance.vision/api/v3/klines?symbol=${symbol}&interval=${interval}&limit=${limit}`,
    { cache: "no-store" }
  );

  if (!res.ok) {
    return NextResponse.json(
      { error: "Failed to fetch Binance data" },
      { status: res.status }
    );
  }

  const data = await res.json();
  return NextResponse.json(data);
}