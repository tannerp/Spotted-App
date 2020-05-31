import { Router, Request, Response } from 'express';

import {Op} from 'sequelize';

import { Post } from '../models/Posts';
import * as c from '../../../../config/config';

// import {requireAuth} from './auth.router.ts';

import {requireAuth} from '../../users/routes/auth.router';

import { NextFunction } from 'connect';

const router: Router = Router();



// New Post
router.post('/newpost', requireAuth, async (req: Request, res: Response) => {
    const title = req.body.title;
    const content = req.body.content;
    const email = req.body.user.email;

    console.log(req.body)
    const post =  new Post({user_email: email, title: title, content: content});
    let savedPost;
    try {
        savedPost = post.save();
    } catch (e) {
        // throw e;
        res.status(401).send({isFulfilled: false});
    }
    res.status(201).send({message: "Success"});
});


router.get('/all', requireAuth, async (req: Request, res: Response) => {
    const posts = await Post.findAll({
        where:{
            user_email:{
            [Op.not]: req.body.user.email
            }
        },
        limit: 30
    });
    // console.log(posts);
    res.status(200).send({posts: posts});
});


router.get('/myposts', requireAuth, async (req: Request, res: Response) => {

    console.log(req.body.user);

    
    const posts = await Post.findAll({
        where: {
            user_email: req.body.user.email
        }
    })

    console.log(posts);
    
    res.status(200).send({posts: posts});
});

export const PostRouter: Router = router;
