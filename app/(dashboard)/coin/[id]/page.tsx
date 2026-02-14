import CoinChart from "@/components/CoinChart";

interface CoinDetail {
  id: string;
  name: string;
  symbol: string;
  market_data: {
    current_price: {
      usd: number;
    };
    price_change_percentage_24h: number;
    market_cap: {
      usd: number;
    };
  };
}

async function getCoin(id: string) {
  if (!id) {
    throw new Error("ID is undefined");
  }

  const res = await fetch(
    `https://api.coingecko.com/api/v3/coins/${id}`,
    {
      next: {revalidate: 60}
    }
  );

  if (!res.ok) {
    throw new Error("Failed to fetch coin");
  }

  return res.json();
}

export default async function CoinDetailPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {

  const {id} = await params;
  const coin = await getCoin(id);

  return (
    <section className="font-sans">
      <h1 className="text-4xl font-bold">
        {coin.name} ({coin.symbol})
      </h1>

      <div className="py-10 flex w-full">
        <div className="w-full border border-slate-800 rounded-lg p-6">
          <div className="border border-slate-800 rounded-lg">
            <CoinChart id={id}/>
          </div>

          <div className="pt-5">
            <p>Price: ${coin.market_data.current_price.usd.toLocaleString()}</p>
            <p>24h Change: {coin.market_data.price_change_percentage_24h.toFixed(2)}%</p>
            <p>Market Cap: ${coin.market_data.market_cap.usd.toLocaleString()}</p>
          </div>
        </div>
      </div>
    </section>
  );
}
