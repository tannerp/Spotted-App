import { Router, Request, Response } from 'express';
import { UserRouter } from './users/routes/user.router';
import { PostRouter } from './posts/routes/post.router';
import { callbackify } from 'util';

const router: Router = Router();

router.use('/users', UserRouter);
router.use('/posts', PostRouter);


router.get('/', async (req: Request, res: Response) => {    
    res.send(`V0`);
});

export const IndexRouter: Router = router;