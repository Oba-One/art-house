import React from "react";

import { Web3Props } from "../../hooks/providers/web3";
import { AccountDataProps } from "../../hooks/views/useAccount";

import { AccountInfo } from "../../components/Account/Info";
import { AccountActions } from "../../components/Account/Actions";

interface AccountProps extends AccountDataProps, Web3Props {}

export const Account: React.FC<AccountProps> = ({
  avatarSpring,
  address,
  name,
  handleConnect,
  signMessage,
  login,
  logout,
  error,
  wallets,
  ready,
}) => {
  const web3Props = {
    address,
    handleConnect,
    signMessage,
    login,
    logout,
    error,
    wallets,
    ready,
  };

  return (
    <section className={`grid place-items-center h-full w-full gap-3 px-6`}>
      <div className={`relative w-full`}>
        <AccountInfo
          avatar={"/assets/avatar.png"}
          username={name || address}
          avatarSpring={avatarSpring}
        />
        <AccountActions {...web3Props} />
      </div>
    </section>
  );
};

export default Account;
