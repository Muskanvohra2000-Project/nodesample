module.exports = {
  apps: [
    {
      name: 'nodeapp',
      script: 'app.js',
      instances: 1,
      autorestart: true,
      watch: false,
      max_memory_restart: '200M',
      out_file: '/var/log/nodeapp/out.log',     // ⬅️ standard output log
      error_file: '/var/log/nodeapp/error.log', // ⬅️ error output log
      log_date_format: 'YYYY-MM-DD HH:mm:ss',
      env: {
        NODE_ENV: 'production',
        PORT: 3000
      }
    }
  ]
};
