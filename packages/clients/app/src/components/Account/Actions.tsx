import { Web3Props } from "../../hooks/providers/web3";

import { Button } from "../Button";

interface AccountActionsProps extends Web3Props {}

export const AccountActions: React.FC<AccountActionsProps> = ({
  error,
  address,
  logout,
  handleConnect,
}) => {
  return (
    <div className="flex flex-col gap-3 items-center w-full">
      <Button
        title={address ? "Disconnect" : "Connect"}
        onClick={address ? logout : handleConnect}
      />
      <p className="text-red-500 h-10 line-clamp-2">{error}</p>
    </div>
  );
};
