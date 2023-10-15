declare interface Project {
  id: string;
  projectId: BigInt;
  name: string;
  description: string;
  artistName: string;
  artistAddress: string;
  invocations: BigInt;
  maxInvocations: BigInt;
  activatedAt: BigInt;
  scriptJSON: string;
  active: boolean;
  paused: boolean;
  complete: boolean;
  tokens: Token[];
  pricePerTokenInWei: BigInt;
  currencyAddress: string;
  currencySymbol: string;
  minterConfiguration?: MinterConfiguration;
}

declare interface Account {
  id: string;
}

declare interface Token {
  id: string;
  tokenId: string;
  invocation: BigInt;
  uri: string;
  createdAt: BigInt;
  owner?: Account;
}

declare interface MinterConfiguration {
  basePrice: BigInt;
  startPrice: BigInt;
  priceIsconfigured: boolean;
  currencySymbol: string;
  currencyAddress: string;
  startTime: BigInt;
  endTime: BigInt;
}

declare interface Trait {
  trait_type: string;
  value: string;
}

declare enum OrderDirection {
  ASC = "asc",
  DESC = "desc",
}

declare enum ArtistType {
  MUSICIAN,
  PAINTER,
  WRITER,
  ACTOR,
  GENERATIVE,
}

declare type GenreID =
  | "80f7ea15-2881-4cf2-bc2f-4eb5f585b45f"
  | "e4005860-b485-4e97-bda5-b808d2fa151f"
  | "dcabba0f-4674-496d-b5dc-f4d3de7e32d6"
  | "876b64c8-abbf-4922-b742-d1ece1925ccf"
  | "66c41ee6-00c3-497d-b9a9-4bcbc155cac2"
  | "105e0504-a734-4073-a90b-7ef8506a390d"
  | "bdac4633-6720-46e1-9075-24e3e676b8b1"
  | "a1684551-ba38-43ba-86ac-2de08fdd42c8"
  | "287c111b-8c3d-43b7-8a0d-026205c18fbc"
  | "1a9519c0-9532-4f50-a9f1-d1985d819156"
  | "d144e607-53b3-40a2-b8cc-395f9276dcf6"
  | "ee5692d1-5f25-46b6-b2f7-eb6df5193b97"
  | "cd3ab8b5-2fe0-4833-b56f-9c6314454bb6"
  | "cbdbcfab-2b51-4b62-bdeb-b46f60a63550"
  | "25da3f3d-48d7-450c-b741-e8553dad10af"
  | "6aa9490f-85f2-47d0-8834-74765b27fcdd"
  | "ea395fda-4719-4cfe-9927-09a9968eba45"
  | "b940fe65-1ab8-4f08-aa65-ca11f8e05161"
  | "dd87e8a1-4afc-47b0-9af0-174a63dcaf66"
  | "0e88cc55-e69b-4b05-8be5-2876e8b25bfd"
  | "e08c586e-d6f2-4a78-adaf-38d6cd9e9c2c"
  | "f7283197-70d3-455c-9c3d-93355387e39b"
  | "6a3e2081-a877-44df-a545-593ceb5df420"
  | "8114e9f0-19ce-4067-8a0a-de5ae68c4412"
  | "0aa316c5-f188-482c-8606-d5afc5f33ea4"
  | "46a012e8-6d42-4256-a347-dc65fc4dcd50"
  | "0e2428f1-d477-42d6-9868-a66f026b293f"
  | "ded2ae61-b3a4-40d1-a526-1d60342ded41"
  | "850da70d-2e7d-440f-a0aa-3b567ae249e7"
  | "29a93ae8-f790-4360-ae2c-8bc170f1fd33"
  | "e6a32e85-e7e9-4da6-a2c1-2d4cf53c713c"
  | "0ef643c9-7f35-429f-9d5f-bcf74d694ef1";

declare type GenreName =
  | "Hip-Hop/Rap"
  | "Pop"
  | "Electronic"
  | "Indie"
  | "R&B/Soul"
  | "Dance/EDM"
  | "Alt Rock"
  | "Folk"
  | "Experimental"
  | "House"
  | "Ambient"
  | "Drum/Bass"
  | "World"
  | "Techno"
  | "Latin"
  | "Jazz/Blues"
  | "Downtempo"
  | "Deep House"
  | "Trap"
  | "Soundtrack"
  | "Rock"
  | "Metal"
  | "Disco"
  | "Reggaeton"
  | "Country"
  | "Dubstep"
  | "Classical"
  // | "Piano"
  | "Triphop"
  | "Dancehall"
  | "Bounce"
  | "Reggae";

declare enum GenreEnum {
  WORLD = 0,
  FOLK = 1,
  PIANO = 2,
  CLASSICAL = 3,
  JAZZ_BLUES = 4,
  COUNTRY = 5,
  ROCK = 6,
  POP = 7,
  EXPERIMENTAL = 8,
  SOUNDTRACK = 9,
  REGGAE = 10,
  RNB_SOUL = 11,
  LATIN = 12,
  DISCO = 13,
  AMBIENT = 14,
  ELECTRONIC = 15,
  METAL = 16,
  DANCEHALL = 17,
  HIPHOP_RAP = 18,
  ALT_ROCK = 19,
  HOUSE = 20,
  REGGAETON = 21,
  TECHNO = 22,
  DEEP_HOUSE = 23,
  DOWNTEMPO = 24,
  INDIE = 25,
  DANCE_EDM = 26,
  BOUNCE = 27,
  TRIPHOP = 28,
  DUBSTEP = 29,
  TRAP = 30,
  DRUM_BASS = 31,
}

declare interface GenreData {
  id: GenreID;
  name: GenreName;
}

declare interface Genre {
  id: GenreID;
  name: GenreName;
  count?: number;
}

declare interface Artist {
  id: string;
  name?: string;
  type?: ArtistType;
}

declare interface Experience {
  id: string;
  name: string;
  address: string;
  artist?: Artist;
  genre?: Genre;
}

declare interface StatsQuery {
  genres?: Genre[];
  artists?: Artist[];
  experiences?: Experience[];
  hasMintedExperience?: boolean;
}
