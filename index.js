const express = require('express');
const fetch = require('node-fetch');
const app = express();

app.get('/lb', async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  try {
    const apiResponse = await fetch(
      'https://api.raw365.gg/v2/affiliate-api/leaderboard?apiKey=75e83a38-8d27-4806-8735-7c3471874375&start=2025-12-10T00:00:00&end=2025-12-15T23:59:59'
    );
    const data = await apiResponse.json();
    res.json(data);
  } catch (e) {
    res.status(500).json({error: "api dead"});
  }
});

app.listen(process.env.PORT || 3000);
