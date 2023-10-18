import "./index.css";

import * as React from "react";
import * as ReactDOM from "react-dom/client";
import { WagmiConfig } from "wagmi";
import { BrowserRouter } from "react-router-dom";
import { QueryClientProvider } from "react-query";
import { foundry, scrollSepolia } from "viem/chains";
import { PrivyProvider } from "@privy-io/react-auth";
import { PrivyWagmiConnector } from "@privy-io/wagmi-connector";

import { config, chainConfig } from "./modules/wagmi";
import { reactQueryClient } from "./modules/reactQuery.ts";

import { Web3Provider } from "./hooks/providers/web3";

import App from "./App.tsx";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <WagmiConfig config={config}>
      <PrivyProvider
        appId={import.meta.env.VITE_PRIVY_APP_ID ?? ""}
        config={{
          loginMethods: ["email", "wallet"],
          appearance: {
            theme: "light",
          },
          additionalChains: [foundry, scrollSepolia],
        }}
      >
        <PrivyWagmiConnector wagmiChainsConfig={chainConfig}>
          <QueryClientProvider client={reactQueryClient}>
            <Web3Provider>
              <BrowserRouter>
                <App />
              </BrowserRouter>
            </Web3Provider>
          </QueryClientProvider>
        </PrivyWagmiConnector>
      </PrivyProvider>
    </WagmiConfig>
  </React.StrictMode>
);
