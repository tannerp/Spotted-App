import { Router, Request, Response } from 'express';

import { User } from '../models/User';

import { AuthRouter, requireAuth } from './auth.router';

import { RegisRouter } from './regis.router';

const router: Router = Router();

router.use('/auth', AuthRouter);

router.use('/regis', RegisRouter);

router.get('/', async (req: Request, res: Response) => {
});

router.get('/:id', async (req: Request, res: Response) => {
    let { id } = req.params;
    const item = await User.findByPk(id);
    res.send(item);
});

export const UserRouter: Router = router;