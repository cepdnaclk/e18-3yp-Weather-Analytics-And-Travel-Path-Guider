const router = require("express").Router();
const { Users } = require("../models/Users");
const { SensorData } = require("../models/SensorData");
const helper = require("../helper");
const bcrypt = require("bcryptjs");

router.get("/", async (req, res) => {
    console.log("Page requested " + req.url);

    const dataUsers = {
        email: "ishanfdo1@gmail.com",
        username: "ishanfdo1",
        password: await bcrypt.hash("password", 10),
        name: "Ishan",
    }
    const dataSensors = {
        dateTime: helper.getDateTime(),
        location: "no location",
        device_id: "python script",
        topic: "test",
        temperature: "24",
        humidity: 78,
        isRaining: 0,
        lightIntensity: 156,
        windSpeed: 12,
    }
    try {
        const resultSensors = await SensorData.create(dataSensors);
        const resultUsers = await Users.create(dataUsers)

        res.send("Seeded")
    } catch (err) {
        res.status(500).send("Seeding failed");
    }
});

module.exports = router;