import type { NextRequest } from "next/server"
import { NextResponse } from "next/server"

type Context = {
  params: Promise<{ id: string }>
}

export async function GET(
  req: NextRequest,
  context: Context
) {
  const { id } = await context.params

  const res = await fetch(
    `https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?id=${id}`,
    {
      headers: {
        "X-CMC_PRO_API_KEY": process.env.CMC_API_KEY!,
      },
      cache: "no-store",
    }
  )

  const data = await res.json()

  return NextResponse.json(data)
}