const net = require("net");
const readline = require("readline");

// create new connection
const client = net.createConnection({
  host: "127.0.0.1",
  port: 8000,
});

// log errors
client.on("error", (err) => {
  console.error(err);
});

// handle new connections from clients
client.on("connect", () => {
  // handle each line of data coming in
  let rl = readline.createInterface(client, client);
  rl.on("line", (data) => {
    console.log(data);
  });

  // create a manual HTTP request
  let request = `GET / HTTP/1.1
Host: 127.0.0.1
Accept: text/html
Connection: keep-alive

  `;
  client.write(request);
});
