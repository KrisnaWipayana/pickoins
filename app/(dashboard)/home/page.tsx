interface Coin {
  id: string;
  name: string;
  symbol: string;
  current_price: number;
  market_cap: number;
  price_change_percentage_24h: number;
}

async function getCoins(): Promise<Coin[]> {
  const res = await fetch(
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1",
    {
      next: { revalidate: 60 },
    }
  );

  if (!res.ok) {
    throw new Error("Failed to fetch coins");
  }

  return res.json();
}

export default async function HomePage() {
  const coins = await getCoins();

  return (
    <section className="font-sans">
      <h1 className="text-4xl font-bold mb-8">Market</h1>

      <div className="border border-slate-800 rounded-lg overflow-hidden">
        <table className="w-full text-left">
          <thead className="bg-slate-900">
            <tr>
              <th className="p-4">Name</th>
              <th className="p-4">Price</th>
              <th className="p-4">24h</th>
              <th className="p-4">Market Cap</th>
            </tr>
          </thead>

          <tbody>
            {coins.map((coin) => (
              <tr
                key={coin.id}
                className="border-t border-slate-800 hover:bg-slate-900"
              >
                <td className="p-4">
                  <a
                    href={`/coin/${coin.id}`}
                    className="font-semibold"
                  >
                    {coin.name} ({coin.symbol.toUpperCase()})
                  </a>
                </td>

                <td className="p-4">
                  ${coin.current_price.toLocaleString()}
                </td>

                <td
                  className={`p-4 ${
                    coin.price_change_percentage_24h > 0
                      ? "text-green-500"
                      : "text-red-500"
                  }`}
                >
                  {coin.price_change_percentage_24h.toFixed(2)}%
                </td>

                <td className="p-4">
                  ${coin.market_cap.toLocaleString()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
