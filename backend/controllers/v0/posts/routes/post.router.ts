import { Router, Request, Response } from 'express';

import { Post } from '../models/Post';

//Is Auth required?
//import { AuthRouter, requireAuth } from './auth.router';

const router: Router = Router();

//router.use('/auth', AuthRouter);

router.get('/', async (req: Request, res: Response) => {
    res.send('Hello from Post Router');
});

/*router.get('/:id', async (req: Request, res: Response) => {
    let { id } = req.params;
    const item = await User.findByPk(id);
    res.send(item);
});
*/

export const PostRouter: Router = router;