import { Router, Request, Response } from 'express';

import { Post } from '../models/Posts';
import * as c from '../../../../config/config';

import { NextFunction } from 'connect';

const router: Router = Router();

// New Post
router.post('/newpost', async (req: Request, res: Response) => {
    const title = req.body.title;
    const content = req.body.content;

    // console.log(req.body)
    const post =  new Post({title: title, content: content});
    let savedPost;
    try {
        savedPost = post.save();
    } catch (e) {
        // throw e;
        res.status(401).send({isFulfilled: false});
    }
    res.status(201).send({message: "Success"});
});

router.get('/all', async (req: Request, res: Response) => {
    const posts = await Post.findAll({limit: 30});
    // console.log(posts);
    res.status(200).send({posts: posts});
});


router.get('/myposts', async (req: Request, res: Response) => {
    console.log("Getting my posts");

    const posts = await Post.findAll({
        where: {
            userID: 3
        }
    })

    console.log(posts);
    
    res.status(200).send({posts: posts});
});

export const PostRouter: Router = router;
