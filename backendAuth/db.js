const mongoose = require("mongoose");
const {mongodb_url} = require("./config.js");


mongoose.connect(mongodb_url);

const registerSchema = new mongoose.Schema({
   email: String,
   username: String,
   password: String,
});

const User = mongoose.model("User", registerSchema);

module.exports = {User};