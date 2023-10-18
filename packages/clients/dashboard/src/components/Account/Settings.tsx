import React from "react";

interface AccountSettingsProps {
  isStarted?: boolean;
}

export const AccountSettings: React.FC<AccountSettingsProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
