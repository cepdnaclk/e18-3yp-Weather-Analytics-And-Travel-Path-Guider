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


describe('Login route', () => {
    it('Login works and checkToken works', async () => {
        const res = await request('http://localhost:' + process.env.PORT).post('/login').send({
            email: "ishanfdo1@gmail.com",
            password: "password"
        })
        expect(res.statusCode).toEqual(200);
        const token = res.body.token

        const res2 = await request('http://localhost:' + process.env.PORT).post('/login/checkToken').set('Authorization', 'Bearer ' + token)
        expect(res2.statusCode).toEqual(200);
    })



})