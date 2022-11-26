const router = require("express").Router();
const { UserModel } = require("../models/Users");
const bcrypt = require("bcryptjs");

const jwtHelper = require("../middlewares/jwt");

router.post('/', async (req, res) => {
    console.log('Page requested /login' + req.url);
    const userFromDB = await UserModel.findOne({ email: req.body.email });

    if (bcrypt.compareSync(req.body.password, userFromDB.password)) {
        res.send({
            "token": jwtHelper.generateAccessToken({ username: req.body.username }),
            "username": req.body.username
        });
    } else {
        res.status(401).send("Invalid credentials");
    }
})

router.post('/checkToken', jwtHelper.authenticateToken, (req, res) => {
    console.log('Page requested /login' + req.url);
    console.log(req.jwtData.username + " tested token");
    res.sendStatus(200);
})


module.exports = router;