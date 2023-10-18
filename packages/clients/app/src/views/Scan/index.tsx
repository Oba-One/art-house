import React from "react";

import { ScanDataProps } from "../../hooks/views/useScan";

interface ScanViewProps extends ScanDataProps {}

const ScanView: React.FC<ScanViewProps> = ({}) => {
  return (
    <section className="flex flex-col w-full h-full items-center gap-3 px-6 text-center"></section>
  );
};

export default ScanView;
