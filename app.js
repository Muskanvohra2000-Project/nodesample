const express = require('express');
const app = express();
const port = 3000;

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
