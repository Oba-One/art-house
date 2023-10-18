import { Request, Response, Router } from "express";

export const ordersRouter = Router();

// Route that Square API will call when a customer completes a checkout
ordersRouter.post("/created", async function (req: Request, res: Response) {
  const body = req.body as { message: string; signature: string };

  try {
  } catch (error) {
    const _error = error as Error;
    console.error(_error);

    return res.status(400).send({ error: _error.message });
  }
});

// Route that Square API will call when an order's fulfillment is updated
ordersRouter.post("/fulfillment-updated", async function (req: Request, res: Response) {
  const body = req.body as { message: string; signature: string };

  try {
  } catch (error) {
    const _error = error as Error;
    console.error(_error);

    return res.status(400).send({ error: _error.message });
  }
});
