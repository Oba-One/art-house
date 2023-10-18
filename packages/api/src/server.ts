import cors from "cors";
import helmet from "helmet";
import express from "express";
import { SiweMessage } from "siwe";
import session from "express-session";

import { authRouter } from "./routes/auth";
import { goodsRouter } from "./routes/goods";
import { ordersRouter } from "./routes/orders";
import { identityRouter } from "./routes/identity";

declare module "express-session" {
  export interface Session {
    nonce: string | null;
    siwe: SiweMessage | null;
    squareAccessToken: string | null;
  }
}

const server = express();

// Middleware
server.use(require("express").json());
server.use(cors({})); // Adjust the "origin" option as needed
server.use(helmet({}));
server.use(
  session({
    name: "art_house_cookie",
    secret: `${process.env.SESSION_SECRET ?? "issa a secret with minimum length of 32 characters"}}`,
    resave: false,
    saveUninitialized: true,
  }),
);

// Router
server.use("/auth", authRouter);
server.use("/goods", goodsRouter);
server.use("/orders", ordersRouter);
server.use("/identity", identityRouter);

server.get("/status", async function (_req, reply) {
  reply.send({ status: "ok" });
});

export { server };
