const net = require("net");
const readline = require("readline");

// create new connection
const client = net.createConnection({
  host: "127.0.0.1",
  port: 3333,
});

// log errors
client.on("error", (err) => {
  console.error(err);
});

// handle new connections from clients
client.on("connect", () => {
  console.log("client connected");

  // handle each line of data coming in
  let rl = readline.createInterface(client, client);
  rl.on("line", (data) => {
    console.log(data);
  });

  // send a message every second
  let count = 0;
  setInterval(() => {
    client.write("Hello " + count + "\n");
    count++;
  }, 1000);
});
