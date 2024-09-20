const crypto = require("node:crypto");
const { argv } = require('node:process');
const http = require('node:http');
const url = require('node:url');
const querystring = require('node:querystring');

const array = [];
const slots = 10;

const hash = (key) => {
  return crypto
    .createHash("sha256")
    .update(key, "utf8")
    .digest()
    .toString("hex");
};

const slot = (key) => {
  const hashedKey = hash(key);
  const position = parseInt(hashedKey, 16);
  const mappedSlot = position % slots;
  return mappedSlot;
};

const set = (key, value) => {
  console.log(`set ${key} -> ${value}`);
  array[slot(key)] = value;
};

const get = (key) => {
  console.log(`get ${key}`);
  return array[slot(key)];
};
if (argv.at(2) < 10) {
  set("bob", 21);
} else if (10 < argv.at(2) && argv.at(2) < 20) {
  set("alice", 24);
} else {
  set("eve", 19);
}

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });

  const { pathname, query } = url.parse(req.url, true);
  const { key, value } = query;

  if (pathname === '/get' && key) {
    const serverId = parseInt(argv.at(2));
    if (get(key) !== undefined) {
      const retrievedValue = get(key);
      res.end(JSON.stringify({ value: retrievedValue, origin: serverId }));
    } else {
      // Construct the correct URL with a query parameter
      console.log(slot(key))
      if(slot(key) === 2){
      const correctServer = `http://localhost:30${"11"}/get?&key=${encodeURIComponent(key)}`;
      res.writeHead(302, { 'Location': correctServer });
      res.end(`Redirect 302 to ${correctServer}`);}
      else if(slot(key) === 4){
        const correctServer = `http://localhost:30${"11"}/get?&key=${encodeURIComponent(key)}`;
      res.writeHead(302, { 'Location': correctServer });
      res.end(`Redirect 302 to ${correctServer}`);
      }
      
    }
  } else if (pathname === '/set' && key && value) {
    set(key, value);
    res.end(`Value ${value} set for key ${key}`);
  } else {
    res.end('Invalid request');
  }
});

const port = 3000 + parseInt(argv.at(2));

server.listen(port, () => {
  console.log("Started server at http://localhost:" + port);
});

// Testing the database
//console.log(get("bob"));
//console.log(get("alice"));
//console.log(get("eve"));
//console.log(array);
//// Initial setup
//
//// Testing the database
//console.log(get("bob"));
//console.log(get("alice"));
//console.log(get("eve"));
//console.log(array);
