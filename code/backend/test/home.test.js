const path = require('path');
require('dotenv').config({
    path: path.resolve(__dirname, '../.env')
});

const request = require('supertest')

describe('Server online', () => {
    it('Server returns HTTP 200 OK + MongoDB Connected', async () => {
        const res = await request('http://localhost:' + process.env.PORT).get('/')
        expect(res.statusCode).toEqual(200)
    })
})