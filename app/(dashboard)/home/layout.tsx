import Link from "next/link"

export default function HomeLayout({
    children,
}: {
    children: React.ReactNode
}) {
  return (
    <div>
      <main>{children}</main>
    </div>
  )
}