// 1. Require and configure Application Insights at the very top
const appInsights = require('applicationinsights');
appInsights.setup("InstrumentationKey=bfc9ea62-5154-4c3d-bdad-4ee9bdb34cd4;IngestionEndpoint=https://centralindia-0.in.applicationinsights.azure.com/;LiveEndpoint=https://centralindia.livediagnostics.monitor.azure.com/;ApplicationId=8d59dcf4-b44a-4d87-bea8-25b1d151af72") // ⬅️ Use your actual connection string
    .setAutoCollectRequests(true)
    .setAutoCollectPerformance(true)
    .setAutoCollectExceptions(true)
    .setAutoCollectDependencies(true)
    .setAutoDependencyCorrelation(true)
    .start();

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// 2. Access the default telemetry client (optional for custom logs)
const client = appInsights.defaultClient;

// Health check route (important for VMSS load balancer)
app.get('/health', (req, res) => {
  res.send('OK');
});

// Main route
app.get('/', (req, res) => {
  res.send('Hello from Node.js on Azure VMSS ho ra h fr fail kuu');
  client.trackTrace({ message: "Main route hit" }); // Optional trace
});

// 3. Start the app
app.listen(port, () => {
  console.log(`App listening on port ${port}`);
  client.trackEvent({ name: "AppStarted", properties: { port } }); // Optional custom event
});
