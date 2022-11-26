const router = require("express").Router();

const jwtHelper = require("../middlewares/jwt");

router.post('/', (req, res) => {
    console.log('Page requested /login' + req.url);
    if (req.body.username == "ishanfdo1" && req.body.password == "password") {
        res.send({
            "token": jwtHelper.generateAccessToken({ username: req.body.username }),
            "username": req.body.username
        });
    } else {
        res.sendStatus(401);
    }
})

router.post('/checkToken', jwtHelper.authenticateToken, (req, res) => {
    console.log('Page requested /login' + req.url);
    console.log(req.jwtData.username + " tested token");
    res.sendStatus(200);
})


module.exports = router;