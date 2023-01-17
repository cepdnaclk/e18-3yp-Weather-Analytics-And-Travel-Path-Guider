const router = require("express").Router();
const { EmergencyButtonPress } = require("../../models/EmergencyButtonPress");


router.get('/lastEmergencyButtonPress', async (req, res) => {
    res.json(await EmergencyButtonPress.find({
        location: req.params.location
    }).sort({ _id: -1 }).limit(1));
})


module.exports = router;