const net = require("net");
const readline = require("readline");

// create new server
const server = net.createServer();

// log errors
server.on("error", (err) => {
  console.error(err);
});

// handle new connections from clients
server.on("connection", (client) => {
  console.log("client connected", client.address());

  // handle each line of data coming in
  let rl = readline.createInterface(client, client);
  rl.on("line", (data) => {
    try {
      let message = JSON.parse(data);
      console.log(message);

      // send back status
      const message2 = {
        status: "ok",
        count: message.count,
      };
      client.write(JSON.stringify(message2) + "\n");
    } catch (e) {
      console.log("invalid message encoding");
    }
  });
});

// listen on port 3333
server.listen({ host: "0.0.0.0", port: 3333 }, () => {
  console.log("server listening on 0.0.0.0:3333");
});
