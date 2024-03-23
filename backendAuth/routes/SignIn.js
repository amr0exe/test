const express = require("express");
const router = express.Router();

const jwt = require("jsonwebtoken");
const { JWT_SECRET } = require("../config");

const { User } = require("../db");

router.post("/", async (req, res) => {
    const { username, password } = req.body;

    try {
      const user = await User.findOne({username, password});
        
      if(!user) {
        console.log("user not found");
        return res.status(404).send({
            msg: "user not found"
        });
      }

      const token = jwt.sign({ username, userId: user._id }, JWT_SECRET, {expiresIn: "1h"});
      console.log("this is  it", user._id);

      res.status(200).send({
        msg: "user created successfully",
        token
      });

    } catch (err) {
        console.log(err);
        return res.send.status(500).send({
            msg: " Internal server error, user doesn't exits",
        })
    }
});

module.exports = router;