const router = require("express").Router();
const { Users } = require("../models/Users");
const bcrypt = require("bcryptjs");

const jwtHelper = require("../middlewares/jwt");

router.post('/', async (req, res) => {
    console.log('Page requested /signup' + req.url);
    const userFromDB = await Users.findOne({ email: req.body.email });
    if (userFromDB) {
        res.status(409).send({
            "message": "User already exists"
        });
    } else {
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(req.body.password, salt);
        const user = new Users({
            username: req.body.username,
            email: req.body.email,
            password: hash
        });
        await user.save();
        res.send({
            "token": jwtHelper.generateAccessToken({ username: req.body.username }),
            "username": req.body.username
        });
    }

})

module.exports = router;