import axios from "axios";
import { Request, Response, Router } from "express";

import { port } from "../constants";

export const authRouter = Router();

const api_uri = process.env.NODE_ENV === "development" ? `http://localhost:${port}` : `https://api.waves.house`;
const dashboard_uri = process.env.NODE_ENV === "development" ? `http://localhost:3002` : `https://art.waves.house`;

authRouter.get("/auth/square", async function (req: Request, res: Response) {
  const squareAuthURL = `https://connect.squareup.com/oauth2/authorize?client_id=${
    process.env.SQUARE_APP_ID ?? ""
  }&scope=ORDERS_READ+ITEMS_WRITE&session=false&redirect_uri=${api_uri}/auth/square/callback`;

  res.redirect(squareAuthURL);
});

authRouter.post("/auth/square/callback", async function (req: Request, res: Response) {
  const code = req.query.code as string | undefined;

  if (!code) {
    res.send("Error authenticating with Square.");
    return;
  }

  try {
    const response = await axios.post("https://connect.squareup.com/oauth2/token", {
      client_id: process.env.SQUARE_APP_ID ?? "YOUR_SQUARE_APP_ID",
      client_secret: process.env.SQUARE_APP_SECRET ?? "YOUR_SQUARE_APP_SECRET",
      code,
      grant_type: "authorization_code",
      redirect_uri: `${api_uri}/auth/square/callback`,
    });

    req.session.squareAccessToken = response.data.access_token;

    res.redirect(`${dashboard_uri}/auth?square-authenticated=true`);
  } catch (error) {
    res.send("Error authenticating with Square.");

    res.redirect(`${dashboard_uri}/auth?square-authenticated=false`);
  }
});
