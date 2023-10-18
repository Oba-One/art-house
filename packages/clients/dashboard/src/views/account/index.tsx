import { a, useSpring, config } from "@react-spring/web";

import { Web3Props } from "../../hooks/providers/web3";
import { AccountDataProps } from "../../hooks/views/useAccount";

interface AccountProps extends AccountDataProps, Web3Props {}

export const AccountView: React.FC<AccountProps> = () => {
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
