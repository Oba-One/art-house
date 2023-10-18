import { a, useSpring, config } from "@react-spring/web";

import { ArtDataProps } from "../../hooks/views/useArt";

interface ArtProps extends ArtDataProps {}

export const ArtView: React.FC<ArtProps> = () => {
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
    ></a.main>
  );
};
