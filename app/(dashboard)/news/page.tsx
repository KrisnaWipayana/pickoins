interface Image {
  size: string;
  url: string;
}

interface Channel {
  name: string;
}

interface Stock {
  name: string;
  exchange: string;
  cusip?: string;
  isin?: string;
}

interface Tags {
  name: string;
}

interface NewsItem {
  id: number;
  author: string;
  created: string;
  updated: string;
  title: string;
  teaser: string;
  body: string;
  url: string;
  image: Image[];
  channels: Channel[];
  stocks: Stock[];
  tags: Tags[];
}

async function getNews(): Promise<NewsItem[]> {
  const apiKey = process.env.BNZ_API_KEY;

  if (!apiKey) {
    throw new Error("Missing BENZINGA_API_KEY");
  }

  const url = new URL("https://api.benzinga.com/api/v2/news");
  url.searchParams.append("token", apiKey);
  url.searchParams.append("displayOutput", "headline");
  url.searchParams.append("topic_group_by", "or");
  url.searchParams.append("output", "json");

  const response = await fetch(url.toString(), {
    cache: "no-store",
    headers: {
      Accept: "application/json",
    }
  });

  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(
      `Benzinga API Error: ${response.status} ${response.statusText} - ${errorText}`
    );
  }

  const data: NewsItem[] = await response.json();
  return data;
}

export default async function News() {
  const items = await getNews();

  return (
    <div>
      <h1 className="text-4xl font-bold mb-8">News</h1>

      <div className="space-y-8">
        {items.map((item) => (
          <div
            key={item.id}
            className="border border-slate-800 rounded-xl p-6 bg-slate-900/40"
          >
            <h2 className="text-xl font-semibold mb-3">
              {item.title}
            </h2>

            <p className="text-sm text-slate-400 mb-4">
              By {item.author} •{" "}
              {new Date(item.created).toLocaleDateString()}
            </p>

            <a
              href={item.url}
              target="_blank"
              className="text-blue-400 hover:underline"
            >
              Read full article →
            </a>
          </div>
        ))}
      </div>
    </div>
  );
}
