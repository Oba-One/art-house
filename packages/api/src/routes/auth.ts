import axios from "axios";
import { Request, Response, Router } from "express";

import { port } from "../constants";

export const authRouter = Router();

authRouter.get("/auth/square", async function (req: Request, res: Response) {
  const redirect_uri = `http://localhost:${port}/auth/square/callback`;
  const squareAuthURL = `https://connect.squareup.com/oauth2/authorize?client_id=YOUR_SQUARE_APP_ID&response_type=code&redirect_uri=${redirect_uri}`;
  res.redirect(squareAuthURL);
});

//connect.squareup.com/oauth2/authorize?client_id={YOUR_APP_ID}&scope=MERCHANT_PROFILE_READ&redirect_uri=http://localhost:8000.

https: authRouter.post("/auth/square/callback", async function (req: Request, res: Response) {
  const code = req.query.code as string | undefined;
  const redirect_uri = `http://localhost:${port}/auth/square/callback`;

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
      redirect_uri,
    });

    req.session.squareAccessToken = response.data.access_token;

    res.send("Successfully authenticated with Square!");
  } catch (error) {
    res.send("Error authenticating with Square.");
  }
});
