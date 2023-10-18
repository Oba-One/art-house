import React from "react";

interface ArtCardProps {
  isStarted?: boolean;
}

export const ArtCard: React.FC<ArtCardProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
