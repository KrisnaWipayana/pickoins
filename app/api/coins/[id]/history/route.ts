export async function GET(
  req: Request,
  context: { params: Promise<{ id: string }> }
) {
  const { id } = await context.params;

  if (!id) {
    return Response.json({ error: "Missing ID" }, { status: 400 });
  }

  const { searchParams } = new URL(req.url);
  const daysParam = searchParams.get("days") || "30";

  const allowedDays = ["1", "7", "30", "90", "365"];
  const days = allowedDays.includes(daysParam) ? daysParam : "30";

  const res = await fetch(
    `https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=usd&days=${days}`,
    {
      next: { revalidate: 120 },
    }
  );

  if (!res.ok) {
    const text = await res.text();
    return Response.json(
      { error: "Failed to fetch", detail: text },
      { status: res.status }
    );
  }

  const data = await res.json();

  return Response.json(data);
}