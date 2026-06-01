require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(cors({
  origin: process.env.ALLOWED_ORIGIN || 'http://localhost:3000'
}));
app.use(express.json());

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

app.get('/api/components', async (req, res) => {
  const { data, error } = await supabase
    .from('components')
    .select('*')
    .order('category')
    .order('price');

  if (error) {
    console.error(error);
    return res.status(500).json({ error: 'Failed to fetch components' });
  }
  res.json(data);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`PCMaxing API running on port ${PORT}`));
