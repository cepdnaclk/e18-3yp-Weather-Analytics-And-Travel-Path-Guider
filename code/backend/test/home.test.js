const path = require('path');
require('dotenv').config({
    path: path.resolve(__dirname, '../.env')
});
const request = require('supertest');
const db = require('../db');

const { SensorData } = require('../models/SensorData');

beforeAll(async () => {
    await db.connectDB();
})
afterAll(async () => {
    await db.disconnectDB();
})

describe('Root route', () => {
    it('Server returns HTTP 200 OK + MongoDB Connected', async () => {
        const res = await request('http://localhost:' + process.env.PORT).get('/')
        expect(res.statusCode).toEqual(200)
    })

    it('Clearing data in db', async () => {
        await request('http://localhost:' + process.env.PORT).get('/clear').expect(200);
        const allData = await SensorData.find()
        expect(allData.length).toEqual(0);
    })
})