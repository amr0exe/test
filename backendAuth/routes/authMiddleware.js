const { JWT_SECRET } = require("../config");
const jwt = require("jsonwebtoken");

const authMiddleware = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    // console.log("this", authHeader);

    if(!authHeader || !authHeader.startsWith("Bearer ")) {
        return res.status(401).send({
            msg: "access denied, not authenticated",
            authHeader
        });
    }

    const token = authHeader.split(" ")[1];

    try {
        console.log(token);
        const decoded = jwt.verify(token, JWT_SECRET);
        req.user = decoded;
        next();
    } catch(err) {
        if (err.name === 'TokenExpiredError') {
            return res.status(401).json({ msg: "Token expired" });
        }
        return res.status(401).json({ msg: "Invalid token" });
    }

};

module.exports = authMiddleware;