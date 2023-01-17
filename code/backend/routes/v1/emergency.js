const router = require("express").Router();
const { Users } = require("../../models/Users");


router.get('/lastEmergencyButtonPress', async (req, res) => {
    res.send("123");
})


module.exports = router;