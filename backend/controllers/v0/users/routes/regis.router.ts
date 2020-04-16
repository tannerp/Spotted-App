import { Router, Request, Response } from 'express';

import { EmailVerify } from '../models/EmailVerify';
import * as c from '../../../../config/config';
import * as AWS from '../../../../aws';

import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
import { NextFunction } from 'connect';

import * as EmailValidator from 'email-validator';
import { config } from 'bluebird';

const router: Router = Router();


    // //register a new user
    // router.post('/', async (req: Request, res: Response) => {
    //     const email = req.body.email;
    //     const plainTextPassword = req.body.password;
    //     // check email is valid
    //     if (!email || !EmailValidator.validate(email)) {
    //         return res.status(400).send({ auth: false, message: 'Email is required or malformed' });
    //     }
    
    //     // check email password valid
    //     if (!plainTextPassword) {
    //         return res.status(400).send({ auth: false, message: 'Password is required' });
    //     }
    
    //     // find the user
    //     const user = await User.findByPk(email);
    //     // check that user doesnt exists
    //     if(user) {
    //         return res.status(422).send({ auth: false, message: 'User may already exist' });
    //     }
    
    //     const password_hash = await generatePassword(plainTextPassword);
    
    //     const newUser = await new User({
    //         email: email,
    //         password_hash: password_hash
    //     });
    
    //     let savedUser;
    //     try {
    //         savedUser = await newUser.save();
    //     } catch (e) {
    //         throw e;
    //     }
    
    //     // Generate JWT
    //     const jwt = generateJWT(savedUser);
    
    //     res.status(201).send({token: jwt, user: savedUser.short()});
    // });

router.post('/', async (req: Request, res: Response) => {
    
    // body.body is for ios
    const email = req.body.email || req.body.body;    

    const newEmail = await new EmailVerify({
        email: email,
        name: "tanner phan"
    });

    let savedVrfEmail;
    
    try{
        savedVrfEmail = await newEmail.save();

    }catch(e){
        // console.error(e)
        // mysql deplicate code ER_DUP_ENTRY
        throw e;
    }

    let verifyEmailLink: string = "tannerphan.com"
    try{
        AWS.sendEmail(email, "Tanner Phan", verifyEmailLink);
    }catch(e){
        throw e;
    }


    
    console.log("POST EMAIL: " + email);

    res.send('auth')
});

export const RegisRouter: Router = router;