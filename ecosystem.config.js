module.exports = {
  apps: [
    {
      name: 'nodeapp',
      script: 'app.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '200M',
      env: {
        NODE_ENV: 'production',
        PORT: 3000
      }
    }
  ]
};
