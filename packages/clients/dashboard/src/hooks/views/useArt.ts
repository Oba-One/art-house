import { ArtHouseDataProps, useArtHouse } from "../providers/artHouse";
// import { WaveDataProps, useWave } from "../wave/useWave";

export interface ArtDataProps extends ArtHouseDataProps {}

export const useArt = (): ArtDataProps => {
  const artHouse = useArtHouse();

  return {
    ...artHouse,
  };
};
