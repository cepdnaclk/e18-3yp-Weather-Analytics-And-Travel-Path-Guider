require('dotenv').config()

const request = require('supertest')

describe('Server online', () => {
    it('Server should return HTTP 200 OK + MongoDB Connected', async () => {
        const res = await request('http://localhost:8080').get('/')
        expect(res.statusCode).toEqual(200)
    })
})