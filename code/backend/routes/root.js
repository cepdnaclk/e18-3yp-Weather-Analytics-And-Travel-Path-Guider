const { SensorData } = require("../models/SensorData");
const { Users } = require("../models/Users");

const router = require("express").Router();

router.get('/', async (req, res) => {
    console.log('Page requested ' + req.url);
    res.json(await SensorData.find().sort({ _id: -1 }).limit(100))
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