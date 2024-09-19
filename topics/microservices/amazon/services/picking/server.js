const mqtt = require("mqtt");
const broker = mqtt.connect("mqtt://mosquitto");

// print connected message
broker.on("connect", () => {
  console.log("connected: mqtt://mosquitto");
});

// print error message
broker.on("error", (err) => {
  console.error(err);
});

const handlers = {
  warehouse_pick: (message) => {
    const item = message;

    // simulate processing time
    setTimeout(() => {
      console.log("picked:");
      console.log(item);

      // publish
      broker.publish("picking_completed", JSON.stringify(item));
    }, parseInt(Math.random() * 2000));
  },
};

// subscribe topics
for (const topic in handlers) {
  broker.subscribe(topic, () => {
    console.log("subscribed: ", topic);
  });
}

// handle messages
broker.on("message", function (topic, data) {
  // parse message
  const message = JSON.parse(data.toString());
  console.log("message:", topic);
  console.log(message);

  // call handler
  handlers[topic](message);
});
