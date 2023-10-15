import { ApolloClient, InMemoryCache, gql } from "@apollo/client";

export const apolloClient = new ApolloClient({
  uri: import.meta.env.DEV
    ? "http://localhost:8080/query"
    : "https://api.syn.art/query",
  cache: new InMemoryCache(),
});

export const GET_STATS = gql`
  query GetStats($address: String!) {
    stats(address: $address) {
      genres {
        id
        name
        count
      }
      artists {
        id
        name
        type
      }
      experiences {
        id
        name
        address
        artist {
          id
          name
        }
        genre {
          id
          name
        }
      }
      hasMintedExperience
    }
  }
`;
