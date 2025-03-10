const express = require('express');
const serverless = require('serverless-http');

const app = express();
//const EXPRESS_PORT = process.env.EXPRESS_PORT || 4000;

app.get('/info', (req, res) => {
    res.status(200).json({ info: 'preset text' });
});

app.get('/', (req, res) => {
    res.send('Backend is running.... Please use API routes like /info.');
});

//app.listen(EXPRESS_PORT, () =>
//    console.log(`Backend started on port: ${EXPRESS_PORT}`)
//);

module.exports.handler = serverless(app);
