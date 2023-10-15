import React from "react";
import ReactDOM from "react-dom/client";

import { Provider } from "urql";
import { WagmiConfig } from "wagmi";
import { foundry } from "viem/chains";
import { BrowserRouter } from "react-router-dom";
import { PrivyProvider } from "@privy-io/react-auth";
import { PrivyWagmiConnector } from "@privy-io/wagmi-connector";

import { urqlClient } from "./modules/urql";
import { config, chainConfig } from "./modules/wagmi";

import { AppProvider } from "./hooks/providers/app";
import { Web3Provider } from "./hooks/providers/web3";

import App from "./App.tsx";

import "./index.css";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <Provider value={urqlClient}>
      <WagmiConfig config={config}>
        <PrivyProvider
          appId={import.meta.env.VITE_PRIVY_APP_ID ?? ""}
          // onSuccess={handleLogin}
          config={{
            loginMethods: ["email", "wallet"],
            appearance: {
              theme: "light",
              // accentColor: "#d6d0cb",
            },
            additionalChains: [foundry],
          }}
        >
          <PrivyWagmiConnector wagmiChainsConfig={chainConfig}>
            <BrowserRouter>
              <AppProvider>
                <Web3Provider>
                  <App />
                </Web3Provider>
              </AppProvider>{" "}
            </BrowserRouter>
          </PrivyWagmiConnector>
        </PrivyProvider>
      </WagmiConfig>
    </Provider>
  </React.StrictMode>
);
