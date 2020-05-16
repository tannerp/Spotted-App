import { Router, Request, Response } from 'express';

import * as c from '../../../../config/config';
import * as AWS from '../../../../aws';
import * as smartunique from '@pushrocks/smartunique';
import * as jwt from 'jsonwebtoken';

// Models
import { User } from '../models/User';
import { generatePassword, generateJWT } from './auth.router';
import { EmailVerify } from '../models/EmailVerify';
// Security
import * as bcrypt from 'bcrypt';
import { NextFunction } from 'connect';
// Tools
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
        // TODO
    });
    
    let savedVrfEmail;
    try{
        savedVrfEmail = await ev.save();
    }catch(e){
        // console.error(e)
        // mysql deplicate code ER_DUP_ENTRY
        throw e;
    }

    // send email
    try{
        AWS.sendRegistrationEmail(ev);
    }catch(e){
        throw e;
    }

    res.send('auth')
});


router.post('/pass', async (req: Request, res: Response) => {

    const hash = req.body.hash;
    const pass = req.body.pass;
    
    // retrieve RegisEmail

    console.log(req.body);
    const user_db = await EmailVerify.findByPk(hash);

    // create new user /w password
    if (!user_db) {
        console.error("Unable to find user");
        return res.status(400).send({ auth: false, message: 'Unable to register at this time. Failed creating user.' });

    }

    // delete RegisEmail
    // try{
    //     await user_db.destroy()
    // }catch (e) {
    //     return res.status(400).send({ auth: false, message: 'Unable to register at this time.' });
    // }

    // create hash
    const passhashed = await generatePassword(pass);
    // const user_info = user_db;
    //create new user
    let jwt;
    let user
    try{
        
        user = await new User({
            email: user_db.email,
            first_name: user_db.first_name,
            last_name: user_db.last_name,
            password_hash: passhashed
        })
        let savedUser = user.save().then( user => {
            jwt = generateJWT(user);
            return res.status(200).send({ auth: true, token: jwt, user: user.short()});
        })
    }catch (e) {
        throw e
        return res.status(400).send({ auth: false, message: 'Unable to register at this time. Failed creating user.' });
    }
});

export const RegisRouter: Router = router;