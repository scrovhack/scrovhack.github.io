// index.js
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'application/json'});
  res.end(JSON.stringify({
    runtime: "Node.js",
    message: "Hello from Node",
    time: new Date().toISOString()
  }));
});

server.listen(3000, () => {
  console.log("Node server running on http://localhost:3000");
});
