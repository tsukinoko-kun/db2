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
  order_placed: (message) => {
    const order = message;

    // calculate total
    let total = 0;
    for (const id in order.items) {
      total += order.items[id].price;
    }

    // simulate processing time
    setTimeout(() => {
      // process payment
      const payment = {
        orderId: order.id,
        type: "credit_card",
        number: "3768-3872-xxxx",
        amount: total,
      };

      console.log("payment:");
      console.log(payment);

      // publish
      broker.publish("payment_processed", JSON.stringify(payment));
    }, 1000);
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
