const router = require("express").Router();
const { UserModel } = require("../models/Users");
const bcrypt = require("bcryptjs");

router.get("/", async (req, res) => {
    console.log("Page requested " + req.url);
    const data = {
        email: "ishanfdo1@gmail.com",
        password: await bcrypt.hash("password", 10),
        name: "Ishan",
    }
    UserModel.create(data, (err, data) => {
        if (err) {
            res.send("Error: maybe it already exists");
            return console.error(err);
        } else {

            res.send("Seeded!");
        }
    })
});

module.exports = router;