const express = require("express");
const router = express.Router();

const authMiddleware = require("./authMiddleware");

router.get("/", authMiddleware, (req, res) => {
    console.log('uc')
    // res.status(203).send({
    //     msg: "user authenticated successfully"
    // });
});

module.exports = router;