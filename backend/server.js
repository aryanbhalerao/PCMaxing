const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root', 
  password: 'admin', 
  database: 'pcmaxing'
});

app.get('/api/components', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM components ORDER BY category, price ASC');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database query failed' });
  }
});

const PORT = 5000;
app.listen(PORT, () => console.log(`PCMaxing API running on port ${PORT}`));