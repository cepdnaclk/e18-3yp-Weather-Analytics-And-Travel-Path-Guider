const { SensorData } = require("../models/SensorData");

const router = require("express").Router();

router.get('/', (req, res) => {
    console.log('Page requested ' + req.url);
    SensorData.find(function (err, data) {
        if (err) return console.error(err);
        res.send(JSON.parse(JSON.stringify(data)));
    })
})

router.get('/clear', (req, res) => {
    console.log('Page requested ' + req.url);
    SensorData.deleteMany({}, function (err) {
        if (err) return console.error(err);
        res.send("Deleted all data");
    });
})

module.exports = router;