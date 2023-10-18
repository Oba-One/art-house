import { ArtHouseDataProps, useArtHouse } from "../providers/artHouse";

export interface CommunityDataProps extends ArtHouseDataProps {}

export const useCommunity = (): CommunityDataProps => {
  const artHouse = useArtHouse();

  return {
    ...artHouse,
  };
};
