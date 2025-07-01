const express = require('express');
const app = express();
const port = process.env.PORT || 3000; // ✅ use env PORT

// Health check route (important for VMSS load balancer)
app.get('/health', (req, res) => {
  res.send('OK');
});

// Main route
app.get('/', (req, res) => {
  res.send('Hello from Node.js on Azure VMSS ho ra h fr fail kuu');
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
