const { SensorData } = require("../../models/SensorData");

const router = require("express").Router();

router.get('/latestReading/:location', async (req, res) => {
    console.log('Page requested ' + req.url)
    res.json(await SensorData.find({
        location: req.params.location
    }).sort({ _id: -1 }).limit(1))
})


module.exports = router;