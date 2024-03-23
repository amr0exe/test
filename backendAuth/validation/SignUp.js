const zod = require("zod");

const registerSchema = zod.object({
   email: zod.string().email(),
   username: zod.string().min(5),
   password: zod.string(),
});

module.exports = {
   registerSchema
};