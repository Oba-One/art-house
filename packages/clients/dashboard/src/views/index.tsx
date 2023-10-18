import { a, useSpring, config } from "@react-spring/web";
import { Navigate, Route, Routes } from "react-router-dom";

import { useArt } from "../hooks/views/useArt";
import { useCommunity } from "../hooks/views/useCommunity";
import { useAccount } from "../hooks/views/useAccount";

import { ArtView } from "./art";
import { ArtViewer } from "./art/Viewer";
import { CommunityView } from "./community";
import { CommunityViewer } from "./community/Viewer";
import { AccountView } from "./account";

const Views = () => {
  const style = useSpring({
    to: {},
    config: {
      ...config.slow,
    },
  });

  const art = useArt();
  const community = useCommunity();
  const account = useAccount();

  return (
    <a.main
      className={`relative h-[calc(100svh+4rem)] py-4 sm:py-16 md:py-24`}
      style={style}
    >
      <Routes location={location}>
        <Route path="art" element={<ArtView {...art} />}>
          <Route path=":address" element={<ArtViewer {...art} />} />
        </Route>
        <Route path="community" element={<CommunityView {...community} />}>
          <Route path=":address" element={<CommunityViewer {...community} />} />
        </Route>
        <Route path="account" element={<AccountView {...account} />} />
        <Route path="*" element={<Navigate to="art" />} />
      </Routes>
    </a.main>
  );
};

export default Views;
