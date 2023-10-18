import React from "react";

interface HouseDialogProps {
  isStarted?: boolean;
}

export const HouseDialog: React.FC<HouseDialogProps> = () => {
  return (
    <dialog
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></dialog>
  );
};
