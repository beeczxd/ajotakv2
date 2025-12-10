const express = require('express');
const fetch = require('node-fetch');
const app = express();

app.get('/lb', async (req, res) => {
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Cache-Control', 'no-cache');

  try {
    const response = await fetch(
      'https://api.raw365.gg/v2/affiliate-api/leaderboard?apiKey=75e83a38-8d27-4806-8735-7c3471874375&start=2025-12-11T00:00:00&end=2025-12-25T23:59:59',
      {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0 Safari/537.36',
          'Accept': 'application/json',
          'Referer': 'https://raw365.gg/',
          'Origin': 'https://raw365.gg'
        }
      }
    );

    const data = await response.json();
    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'blocked by cloudflare' });
  }
});

app.listen(process.env.PORT || 3000);
