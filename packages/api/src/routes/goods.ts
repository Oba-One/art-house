import { Request, Response, Router } from "express";

export const goodsRouter = Router();

// Route to post products to Square API
goodsRouter.post("/upsert", async function (req: Request, res: Response) {
  req.session.destroy(() => res.status(200).send(true));
});
