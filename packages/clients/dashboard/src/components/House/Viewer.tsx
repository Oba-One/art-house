import React from "react";

interface HouseViewerProps {
  isStarted?: boolean;
}

export const HouseViewer: React.FC<HouseViewerProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
