"use client"

import Link from "next/link"
import { useState } from "react"

export default function Sidebar() {
  const [open, setOpen] = useState(false)

  return (
    <>
      {/* Mobile Toggle Button */}
      <button
        onClick={() => setOpen(true)}
        className="md:hidden fixed top-4 left-4 z-50 p-2 rounded-md bg-slate-900 text-slate-100"
      >
        ☰
      </button>

      {/* Overlay (Mobile) */}
      {open && (
        <div
          className="fixed inset-0 bg-black/50 z-40 md:hidden"
          onClick={() => setOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`
          fixed md:static top-0 left-0 z-50
          h-screen w-64
          bg-slate-950 border-r border-slate-800
          transform transition-transform duration-200
          ${open ? "translate-x-0" : "-translate-x-full"}
          md:translate-x-0
        `}
      >
        {/* Logo */}
        <div className="px-6 py-5 text-xl font-bold text-slate-50">
          <Link href="/">Lorems</Link>
        </div>
        {/* Navigation */}
        <nav className="px-2">
          <ul className="flex flex-col gap-1 text-slate-200">
            <li>
              <Link
                href="/home"
                className="block px-4 py-2 rounded-md hover:bg-slate-800"
                onClick={() => setOpen(false)}
              >
                Latest Coins
              </Link>
            </li>
            <li>
              <Link
                href="/settings"
                className="block px-4 py-2 rounded-md hover:bg-slate-800"
                onClick={() => setOpen(false)}
              >
                Settings
              </Link>
            </li>
            <li>
              <Link
                href="/dashboard"
                className="block px-4 py-2 rounded-md hover:bg-slate-800"
                onClick={() => setOpen(false)}
              >
                Dashboard
              </Link>
            </li>
          </ul>
        </nav>
      </aside>
    </>
  )
}
