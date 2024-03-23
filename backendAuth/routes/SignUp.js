const express = require("express");
const router = express.Router();

const { registerSchema } = require("../validation/SignUp.js");
const { User } = require("../db.js");

router.post("/", async (req, res) => {
   const { email, username, password} = req.body;
   const result = registerSchema.safeParse(req.body);   

   //check for zod validaiton of inputs
   if(!result.success) {
      return res.status(411).send({
         msg: "invalid inputs"
      })
   }

   //check existing User
   const existUser = await User.findOne({
      $or: [
         {username}, {email}
      ]
   });
   console.log(existUser);

   if(existUser) {
      return res.status(422).send({
         msg: "user already exists"
      })
   }
   //create user
   const newUser = await User.create({
      email,
      username,
      password
   });


   res.send({
      msg: "data reached succesfully!.."
   })
});


module.exports = router;
