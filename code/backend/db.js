const mongoose = require('mongoose');

async function connectDB() {
    const db = mongoose.connection;
    db.on("error", console.error.bind(console, "MongoDB connection error:"));
    db.on("connected", () => {
        console.log("MongoDB Connected");
    });
    await mongoose.connect(process.env.MONGO_URL);
}

async function disconnectDB() {
    await mongoose.connection.close();
}

module.exports = { connectDB, disconnectDB };