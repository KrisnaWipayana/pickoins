import Link from "next/link"

export default function Footer() {
  return (
    <footer className="border-t border-slate-800 bg-slate-950 md:ml-64">
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">

          {/* Brand */}
          <div>
            <h3 className="text-slate-100 font-semibold text-lg">
              Lorems
            </h3>
            <p className="text-sm text-slate-400 mt-1">
              Market insights, sentiment tracking, and real-time crypto news.
            </p>
          </div>

          {/* Links */}
          <div className="flex flex-wrap gap-6 text-sm text-slate-300">
            <Link href="/home" className="hover:text-white transition-colors">
              Latest Coins
            </Link>
            <Link href="/bullvsbear" className="hover:text-white transition-colors">
              Bull vs Bear
            </Link>
            <Link href="/news" className="hover:text-white transition-colors">
              News
            </Link>
            <Link href="/settings" className="hover:text-white transition-colors">
              Settings
            </Link>
          </div>
        </div>

        {/* Bottom Row */}
        <div className="mt-8 pt-6 border-t border-slate-800 flex flex-col md:flex-row md:items-center md:justify-between gap-4 text-xs text-slate-500">
          <p>© {new Date().getFullYear()} Lorems. All rights reserved.</p>

          <div className="flex gap-4">
            <Link href="/privacy" className="hover:text-slate-300 transition-colors">
              Privacy Policy
            </Link>
            <Link href="/terms" className="hover:text-slate-300 transition-colors">
              Terms of Service
            </Link>
          </div>
        </div>
      </div>
    </footer>
  )
}
