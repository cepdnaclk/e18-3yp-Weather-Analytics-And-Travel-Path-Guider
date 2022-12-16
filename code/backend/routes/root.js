const { SensorData } = require("../models/SensorData");
const { Users } = require("../models/Users");

const router = require("express").Router();

router.get('/', (req, res) => {
    console.log('Page requested ' + req.url);
    SensorData.find(function (err, data) {
        if (err) return console.error(err);
        res.send(JSON.parse(JSON.stringify(data)));
    })
})

router.get('/count', async (req, res) => {
    console.log('Page requested ' + req.url);
    const count = await SensorData.countDocuments();
    res.send({ count: count });
})

router.get('/clear1', async (req, res) => {
    console.log('Page requested ' + req.url);
    await SensorData.deleteMany({})
    await Users.deleteMany({})

    res.send("Cleared");
})

module.exports = router;