import { a, useTransition } from "@react-spring/web";
import { Navigate, Route, Routes, useLocation } from "react-router-dom";

import { useArt } from "../hooks/views/useArt";
import { useScan } from "../hooks/views/useScan";
import { useAccount } from "../hooks/views/useAccount";

import Art from "./Art";
import Scan from "./Scan";
import Account from "./Account";

export default function Views() {
  const location = useLocation();
  const transitions = useTransition(location, {
    from: { opacity: 0 },
    enter: { opacity: 1 },
    leave: { opacity: 0 },
    exitBeforeEnter: true,
    config: {
      tension: 300,
      friction: 20,
      clamp: true,
    },
  });

  const art = useArt();
  const scan = useScan();
  const account = useAccount();

  return transitions((style, location) => (
    <a.main
      className={`flex h-[calc(100dvh-3.5rem)] overflow-hidden max-h-[calc(100dvh-3.5rem)] overflow-y-contain`}
      style={style}
    >
      <Routes location={location}>
        <Route path="art" element={<Art {...art} />} />
        <Route path="scan" element={<Scan {...scan} />} />
        <Route path="account" element={<Account {...account} />} />
        <Route path="*" element={<Navigate to="account" />} />
      </Routes>
    </a.main>
  ));
}
