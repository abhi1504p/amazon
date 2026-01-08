// Import packages
const express = require("express");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const auth = require("../middleware/auth");


require('dotenv').config();


const authRouter = express.Router();

// signup the user

authRouter.post('/api/signup', async (req, res) => {
    try {
        // get the data from client
        const {name, email, password} = req.body;

        // basic validation

        if (!email || !name || !password) {
            return res.status(400).json({msg: "All field required"})
        }
        const existingUser = await User.findOne({email});
        if (existingUser) {
            return res.status(400).json({msg: "User Already Exists"})
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        // post the data in database
        let user = new User({
            name,
            email,
            password: hashedPassword
        })
        user = await user.save();

        // return the data to user
        res.status(200).json({msg: "User successfully created", user});
    } catch (e) {
        return res.status(500).json({error: e.message})
    }

})

// SignIn the user

authRouter.post('/api/signIn', async (req, res) => {
    try {
        //     get the data from user
        const {email, password} = req.body;

        //     validate it is present or not

        if (!email || !password) {
            return res.status(400).json({msg: "All field required"})
        }
//     find the user in database
        const user = await User.findOne({email});
        if (!user) {
            return res.status(400).json({msg: "User Not Exists"})
        }


        //match the password
        const isMatch = await bcryptjs.compare(password, user.password);


        if (!isMatch) {
            return res.status(400).json({msg: "Invalid credentials"});
        }


        // jsonwebtoken create
        const token = jwt.sign({id: user._id}, process.env.JWT_SECRET)

        // send response back
        res.json({token, ...user._doc});
    } catch (e) {
        res.status(500).json({error: e.message});
    }

})

// get user data validation

authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');

        if (!token) {
            return res.json(false);
        }
        const verified = jwt.verify(token, process.env.JWT_SECRET);
        if (!verified) {
            return res.json(false);
        }
        const user = User.findOne(verified.id);
        if (!user) {
            return res.json(false);
        }
        return res.json(true);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})
// get user data


authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token})
});


module.exports = authRouter;