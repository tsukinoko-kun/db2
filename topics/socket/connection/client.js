const net = require("net");

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

  // handle new chunks of data coming in
  client.on("data", (data) => {
    process.stdout.write(data);
  });

  // send a message every second
  let count = 0;
  setInterval(() => {
    client.write("Hello " + count);
    count++;
  }, 1000);
});
