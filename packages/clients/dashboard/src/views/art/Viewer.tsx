import { a, useSpring, config } from "@react-spring/web";

import { ArtDataProps } from "../../hooks/views/useArt";
import { ArtViewer as ArtworkViewer } from "../../components/Art/Viewer";
import { HouseViewer } from "../../components/House/Viewer";
import { Outlet } from "react-router-dom";

interface ArtViewerProps extends ArtDataProps {
  // address: string;
}

export const ArtViewer: React.FC<ArtViewerProps> = ({
  // address,
  ...artHouse
}) => {
  const style = useSpring({
    to: {},
    config: {
      ...config.slow,
    },
  });

  return (
    <a.main
      className={`relative h-[calc(100svh+4rem)] py-4 sm:py-16 md:py-24`}
      style={style}
    >
      <ArtworkViewer {...artHouse} />
      {/* <HouseViewer /> */}
      <Outlet />
    </a.main>
  );
};
