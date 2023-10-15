import {
  useConnect,
  useAccount,
  useChainId,
  useDisconnect,
  useSignMessage,
} from "wagmi";
import { useState } from "react";
import { SiweMessage } from "siwe";
import { InjectedConnector } from "wagmi/connectors/injected";

import { apiClient } from "../modules/axios";

export const useAuthWeb3 = () => {
  const chainId = useChainId();
  const { address } = useAccount();
  const { connectAsync } = useConnect({
    connector: new InjectedConnector({}),
  });
  const { disconnectAsync } = useDisconnect();
  const { signMessageAsync } = useSignMessage();

  const [error, setError] = useState<null | string>(null);

  async function handleConnect(): Promise<void> {
    try {
      setError(null);
      await connectAsync();
    } catch (err: any) {
      err && err.message && setError(err.message);
      console.error("ERROR CONNECTING WALLET", err);
    }
  }

  async function signMessage(message: string): Promise<string | void> {
    try {
      setError(null);
      const msg = await signMessageAsync({ message });
      return msg;
    } catch (err: any) {
      err && err.message && setError(err.message);
      console.error("ERROR SIGNING MSG", err);
    }
  }

  async function authenticate() {
    try {
      setError(null);

      if (!address) {
        await handleConnect();
      }

      const nonceRes = await apiClient.get(`/user/identifier/nonce`, {});

      const nonce = await nonceRes.data;

      const message = new SiweMessage({
        address,
        chainId,
        nonce,
        domain: window.location.host,
        statement: "Authenticate with WEFA to access AI powered services.",
        uri: window.location.origin,
        version: "0.0.0",
      });
      const signature = signMessage(message.prepareMessage());

      await apiClient.post(`/user/identifier/login`, {
        body: {
          message,
          signature,
        },
      });
    } catch (err: any) {
      err && err.message && setError(err.message);
      console.error("ERROR AUTHENTICATING", err);
    }
  }

  async function handleDisconnect(): Promise<void> {
    try {
      setError(null);
      await disconnectAsync();
      await apiClient.post(`/user/logout`);
    } catch (err: any) {
      err && err.message && setError(err.message);
      console.error("ERROR DICONNECTING WALLET", err);
    }
  }

  return {
    error,
    address,
    handleConnect,
    signMessage,
    authenticate,
    handleDisconnect,
  };
};
