const mongoose = require('mongoose');

async function connectDB() {
    await mongoose.connect(process.env.MONGO_URL);
    const db = mongoose.connection;
    db.on("error", console.error.bind(console, "MongoDB connection error:"));
    db.on("connected", () => {
        console.log("MongoDB Connected");
    });
}

async function disconnectDB() {
    await mongoose.connection.close();
}

module.exports = { connectDB, disconnectDB };