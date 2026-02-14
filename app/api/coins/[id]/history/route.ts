export async function GET(
  req: Request,
  context: { params: Promise<{ id: string }> }
) {
  const { id } = await context.params;

  console.log("ID FROM API:", id);

  if (!id) {
    return Response.json({ error: "Missing ID" }, { status: 400 });
  }

  const res = await fetch(
    `https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=usd&days=30`,
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

  return Response.json(await res.json());
}
