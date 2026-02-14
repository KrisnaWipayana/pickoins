export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const res = await fetch(
    `https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=${params.id}`,
    {
      headers: {
        "X-CMC_PRO_API_KEY": process.env.CMC_API_KEY!,
      },
      cache: "no-store",
    }
  );

  const data = await res.json();

  return Response.json(data);
}
