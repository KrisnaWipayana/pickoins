export async function GET(
  req: Request,
) {

  const res = await fetch(
    `https://api.benzinga.com/api/v1/bulls_bears_say`,
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
