import { Router, Request, Response } from 'express';

import { User } from '../models/User';

import { AuthRouter, requireAuth } from './auth.router';

import { RegisRouter } from './regis.router';

const router: Router = Router();

router.use('/auth', AuthRouter);

router.use('/regis', RegisRouter);



// router.get('/:id', async (req: Request, res: Response) => {
//     let { id } = req.params;
//     const item = await User.findByPk(id);
//     res.send(item);
// });

router.get('/profile', requireAuth, async (req: Request, res: Response) => {

    const user = await User.findOne({
        where:{
            email: req.body.user.email
        }
    });
    
    res.status(200).send(user);
});


// router.get('/', async (req: Request, res: Response) => {
// });

export const UserRouter: Router = router;