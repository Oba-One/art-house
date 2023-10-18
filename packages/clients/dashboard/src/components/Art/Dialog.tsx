import React from "react";

interface ArtDialogProps {
  isStarted?: boolean;
}

export const ArtDialog: React.FC<ArtDialogProps> = () => {
  return (
    <dialog
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></dialog>
  );
};
