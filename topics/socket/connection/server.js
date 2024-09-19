const net = require("net");

// create new server
const server = net.createServer();

// log errors
server.on("error", (err) => {
  console.error(err);
});

// handle new connections from clients
server.on("connection", (client) => {
  console.log("client connected", client.address());

  // handle new chunks of data coming in
  client.on("data", (data) => {
    process.stdout.write(data);
  });
});

// listen on port 3333
server.listen({ host: "0.0.0.0", port: 3333 }, () => {
  console.log("server listening on 0.0.0.0:3333");
});
