import React from "react";

interface HouseCardProps {
  isStarted?: boolean;
}

export const HouseCard: React.FC<HouseCardProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
