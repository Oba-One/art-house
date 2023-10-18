declare interface Timestamp {
  created_at?: string;
  updated_at?: string;
}

declare interface Member extends Timestamp {
  id: string; // ERC-6551 Account Address

  artworks?: Art[];
  houses?: House[];
}

declare interface House extends Timestamp {
  id: string; // ERC-6551 Account Address

  artworks?: Art[];
}

declare interface Art extends Timestamp {
  id: string; // ERC-6551 Account Address
}
