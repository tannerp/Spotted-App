import { Router, Request, Response } from 'express';

import { Post } from '../models/Posts';
import * as c from '../../../../config/config';

import { NextFunction } from 'connect';

import * as EmailValidator from 'email-validator';

const router: Router = Router();

// New Post
router.post('/newpost', async (req: Request, res: Response) => {
    const title = req.body.title;
    const content = req.body.content;

    // console.log(req.body)
    const post =  await new Post({title: title, content: content});
    let savedPost;
    try {
        savedPost = post.save();
    } catch (e) {
        throw e;
    }
    res.status(201).send({message: "Success"});
});

router.get('/all', async (req: Request, res: Response) => {
    res.send('auth')
});

export const PostRouter: Router = router;
