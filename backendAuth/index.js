const express = require("express");
const cors = require('cors');
const app = express();

const SignUpRouter = require("./routes/SignUp.js")
const SignInRouter = require("./routes/SignIn.js");
const authRouter = require("./routes/ProtectedPage.js");
const corsOption = {
    origin: "http://localhost:5173"
};

app.use(cors(corsOption));
app.use(express.json());

app.use("/signup", SignUpRouter);
app.use("/signin", SignInRouter);
app.use("/protected", authRouter);


app.get("/", (req, res) => {
    res.send("home Page");
})

app.listen(3000, () => {
    console.log(`listening on http://localhost:3000`)
})