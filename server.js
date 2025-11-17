const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || 'nsolid-tt-app';

app.get('/', (_req, res) => {
  res.json({
    msg: 'hello world',
    app: APP_NAME,
    timestamp: new Date().toISOString(),
  });
});

app.get('/health', (_req, res) => {
  res.json({
    status: 'ok',
    uptime: process.uptime(),
    timestamp: Date.now(),
  });
});

app.listen(PORT, () => {
  console.log(`[${APP_NAME}] listening on port ${PORT}`);
});