import { a, useSpring, config } from "@react-spring/web";

import { ArtDataProps } from "../../hooks/views/useArt";
import { ArtViewer } from "../../components/Art/Viewer";
import { HouseViewer } from "../../components/House/Viewer";

interface CommunityViewerProps extends ArtDataProps {
  // address: string;
}

export const CommunityViewer: React.FC<CommunityViewerProps> = ({
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
      <ArtViewer {...artHouse} />
      <HouseViewer />
    </a.main>
  );
};
