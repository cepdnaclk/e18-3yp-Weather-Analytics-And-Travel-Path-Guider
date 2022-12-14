const jwt = require('jsonwebtoken');

// https://www.digitalocean.com/community/tutorials/nodejs-jwt-expressjs

function generateAccessToken(data) {
    return jwt.sign(data, process.env.JWT_SECRET, { expiresIn: '3600s' });
}

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    if (token == null) return res.sendStatus(401)

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        console.log(err)

        if (err) return res.sendStatus(403)
        
        req.jwtData = user
        next()
    })
}

module.exports = { generateAccessToken, authenticateToken };
