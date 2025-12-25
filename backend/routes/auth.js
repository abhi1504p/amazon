// Import packages
const express=require("express")

const authRouter=express.Router();


authRouter.post('/api/signup',(req,res)=>{
   // get the data from client
    const {name,email,password}=req.body;

    // post the data in database
    // return the data to user

})

module.exports=authRouter;