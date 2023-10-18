import React from "react";

interface ArtViewerProps {}

export const ArtViewer: React.FC<ArtViewerProps> = () => {
  return (
    <div
      className={`bg-base-100 py-2 px-8 flex items-center justify-between border-b-2`}
    ></div>
  );
};
