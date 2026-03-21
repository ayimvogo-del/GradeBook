const bcrypt = require("bcryptjs");

const hash = bcrypt.hashSync("password", 10);
console.log(hash);

const valide = bcrypt.compareSync("password", hash);
console.log("Verification : ", valide); // true ou false
