const router = require("express").Router();
const jwtHelper = require("../middlewares/jwt");

router.get('/', (req, res) => {
    console.log('Page requested ' + req.url);
    if (req.username == "ishanfdo1" && req.password == "password") {
        res.send(jwtHelper.generateAccessToken({ username: req.username }));
    }
})

module.exports = router;