import { a, useSpring, config } from "@react-spring/web";

import { CommunityDataProps } from "../../hooks/views/useCommunity";

interface CommunityProps extends CommunityDataProps {}

export const CommunityView: React.FC<CommunityProps> = () => {
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
      <div className="relative h-full z-10 py-8 px-6 md:px-12 sm:px-8 max-w-screen-xl sm:mx-auto flex flex-col sm:flex-row-reverse items-center gap-6 sm:gap-8 lg:gap-24"></div>
    </a.main>
  );
};
