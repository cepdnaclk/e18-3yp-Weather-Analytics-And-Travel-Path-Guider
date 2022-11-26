const router = require("express").Router();
const { Users } = require("../models/Users");
const { SensorData } = require("../models/SensorData");
const helper = require("../helper");
const bcrypt = require("bcryptjs");

router.get("/", async (req, res) => {
    console.log("Page requested " + req.url);

    const dataUsers = {
        email: "ishanfdo1@gmail.com",
        password: await bcrypt.hash("password", 10),
        name: "Ishan",
    }
    const dataSensors = {
        dateTime: helper.getDateTime(),
        topic: "test",
        msg: "empty msg",
        sensorType: "test sensor type",

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