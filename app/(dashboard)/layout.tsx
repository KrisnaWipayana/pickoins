import Sidebar from "@/components/navbar";
import { Geist, Geist_Mono } from "next/font/google";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="bg-slate-950 text-slate-100 min-h-screen">
      <Sidebar />
      <main className="flex-1 p-10 md:ml-64">
        {children}
      </main>
    </div>
  );
}
