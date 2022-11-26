const path = require('path');
require('dotenv').config({
    path: path.resolve(__dirname, '../.env')
});
const request = require('supertest');
const db = require('../db');

const { SensorData } = require('../models/SensorData');
const { Users } = require('../models/Users');

beforeAll(async () => {
    await db.connectDB();
})
afterAll(async () => {
    await db.disconnectDB();
})


describe('Seed route', () => {
    it('Seeding works', async () => {
        // clear everything
        const res1 = await request('http://localhost:' + process.env.PORT).get('/clear')
        const results1 = await SensorData.findOne({
            msg: "empty msg"
        });
        expect(results1).toBeNull();

        // seed
        await Users.deleteOne({ email: "ishanfdo1@gmail.com" })
        const res = await request('http://localhost:' + process.env.PORT).get('/seed')
        expect(res.statusCode).toEqual(200);
        const results = await SensorData.findOne({
            msg: "empty msg"
        });
        expect(results.topic).toEqual("test");
    })


})