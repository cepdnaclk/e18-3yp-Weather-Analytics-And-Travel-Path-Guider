const mongoose = require('mongoose');

function connectDB() {
    mongoose.connect(process.env.MONGO_URL);
    const db = mongoose.connection;
    db.on("error", console.error.bind(console, "MongoDB connection error:"));
    db.on("connected", () => {
        console.log("MongoDB Connected");
    });
}

module.exports = { connectDB };