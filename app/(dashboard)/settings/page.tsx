import Link from "next/link";

export default function Settings() {
  return (
    <div className="font-sans">
      <p className="text-4xl font-bold">Settings</p>

      <div className="py-10 flex w-full">
        <div className="w-full border border-slate-800 rounded-lg p-3">
          <div className="p-3">
            <h1 className="text-2xl font-bold">Account</h1>
            <hr className="border border-slate-800 mt-2 mb-2"/>
            <div className="flex flex-col">
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Lorem</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Ipsum</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Dolor</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Sit amet</Link>
            </div>
          </div>

          <div className="p-3">
            <h1 className="text-2xl font-bold">Personalization</h1>
            <hr className="border border-slate-800 mt-2 mb-2"/>
            <div className="flex flex-col">
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Lorem</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Ipsum</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Dolor</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Sit amet</Link>
            </div>
          </div>

          <div className="p-3">
            <h1 className="text-2xl font-bold">Terms and Condition</h1>
            <hr className="border border-slate-800 mt-2 mb-2"/>
            <div className="flex flex-col">
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Lorem</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Ipsum</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Dolor</Link>
              <Link className="hover:bg-slate-800 p-2 rounded-lg" href={""}>Sit amet</Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
