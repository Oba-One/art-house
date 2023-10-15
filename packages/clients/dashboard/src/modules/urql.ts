import { Client, cacheExchange, fetchExchange } from "urql";

export const urqlClient = new Client({
  url:
    import.meta.env.GRAPH_URL ??
    "http://localhost:8000/subgraphs/name/waves-base-goerli",
  exchanges: [cacheExchange, fetchExchange],
});
