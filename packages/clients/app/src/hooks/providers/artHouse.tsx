import { useAccount } from "wagmi";
import { createContext, useContext } from "react";

export interface ArtHouseDataProps {
  members: Member[];
  houses: House[];
  artworks: Art[];
}

type Props = {
  children: React.ReactNode;
};

const ArtHouseContext = createContext<ArtHouseDataProps | null>(null);

export const ArtHouseProvider = ({ children }: Props) => {
  const currentValue = useContext(ArtHouseContext);

  if (currentValue) throw new Error("ArtHouseProvider can only be used once");

  const { } = useAccount();

  return (
    <ArtHouseContext.Provider
      value={{
        members: [],
        houses: [],
        artworks: [],
        // fetchWaveNfts,
      }}
    >
      {children}
    </ArtHouseContext.Provider>
  );
};

export const useArtHouse = () => {
  const value = useContext(ArtHouseContext);
  if (!value) throw new Error("Must be used within a ArtHouseProvider");
  return value;
};
