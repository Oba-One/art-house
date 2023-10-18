import React from "react";

interface AccountCardProps {
  isStarted?: boolean;
}

export const AccountCard: React.FC<AccountCardProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
