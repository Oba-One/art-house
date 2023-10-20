import React from "react";
import { useWeb3 } from "../../hooks/providers/web3";

interface HeaderProps {
  isStarted?: boolean;
}

export const Header: React.FC<HeaderProps> = () => {
  const { activeWallet, login, logout } = useWeb3();

  return (
    <header
      className={`py-2 px-8 flex items-center justify-between border-b-2`}
    >
      <h1 className="font-bold text-4xl">WAVES</h1>
      <div>
        {activeWallet ? (
          <button className="btn btn-primary btn-sm" onClick={logout}>
            Logout
          </button>
        ) : (
          <button className="btn btn-primary btn-sm" onClick={login}>
            Login
          </button>
        )}
      </div>
    </header>
  );
};
