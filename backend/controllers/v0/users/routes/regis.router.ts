import { Router, Request, Response } from 'express';

import { EmailVerify } from '../models/EmailVerify';
import * as c from '../../../../config/config';
import * as AWS from '../../../../aws';
import * as smartunique from '@pushrocks/smartunique';



import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { NextFunction } from 'connect';

import * as EmailValidator from 'email-validator';
import { config } from 'bluebird';

const router: Router = Router();


router.post('/', async (req: Request, res: Response) => {
    
    // body.body is for ios
    const email = req.body.email || req.body.body;
    const fname = req.body.first_name;
    const lname = req.body.last_name;
    const uuid = smartunique.shortId();

    const ev = await new EmailVerify({
        hash: uuid,
        first_name: fname,
        last_name: lname,
        email: email,
        name: "tanner phan"
    });
    
    let savedVrfEmail;
    try{
        savedVrfEmail = await ev.save();
    }catch(e){
        // console.error(e)
        // mysql deplicate code ER_DUP_ENTRY
        throw e;
    }

    try{
        AWS.sendRegistrationEmail(ev);
    }catch(e){
        throw e;
    }

    res.send('auth')
});

export const RegisRouter: Router = router;