interface Security {
	cik: string;
	exchange: string;
	isin: string;
	name: string;
	symbol: string;
}

interface BullBearItem {
	id: string;
	bull_case: string;
	bear_case: string;
	ticker: string;
	updated: number;
	securities: Security[];
}

interface BullBearResponse {
	bulls_say_bears_say: BullBearItem[];
}

async function getBullBear(): Promise<BullBearResponse> {
	const apiKey = process.env.BNZ_API_KEY;

	if (!apiKey) {
		throw new Error("Missing BENZINGA_API_KEY");
	}

	const url = new URL("https://api.benzinga.com/api/v1/bulls_bears_say");
	url.searchParams.append("token", apiKey);
	url.searchParams.append("pagesize", "3");
	url.searchParams.append("parameters", "[3]");

	const response = await fetch(url.toString(), {
		cache: "no-store",
	});

	if (!response.ok) {
		const errorText = await response.text();
		throw new Error(
			`Benzinga API Error: ${response.status} ${response.statusText} - ${errorText}`
		);
	}

	return response.json();
}

export default async function BullvsBear() {

	const data = await getBullBear();
	const items = data.bulls_say_bears_say;

	return (
		<div className="font-sans">

			<h1 className="text-4xl font-bold mb-8">Bull vs Bear</h1>

			{items.map((item) => (
				<div
					key={item.id}
					className="mb-12 border border-slate-800 rounded-xl p-8 bg-slate-900/40"
				>
					<h2 className="text-2xl font-semibold text-center mb-8">
						{item.securities[0]?.name} ({item.ticker})
					</h2>

					<div className="grid md:grid-cols-2 gap-10">
						<div>
							<p className="font-bold text-green-400 mb-3 text-lg">
								Bull Case
							</p>
							<p className="text-slate-300 leading-relaxed">
								{item.bull_case}
							</p>
						</div>

						<div>
							<p className="font-bold text-red-400 mb-3 text-lg">
								Bear Case
							</p>
							<p className="text-slate-300 leading-relaxed">
								{item.bear_case}
							</p>
						</div>
					</div>
				</div>
			))}

		</div>
	);
}
