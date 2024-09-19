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

const mail = (address, subject) => {
  setTimeout(() => {
    console.log("sent:");
    console.log("to:", address);
    console.log("subject:", subject);
  }, parseInt(Math.random() * 1000));
};

const handlers = {
  order_placed: (message) => {
    const order = message;
    mail(order.customer.mail, `Thank you, we received order #${order.id}`);
  },
  order_confirmed: (message) => {
    const order = message;
    mail(order.customer.mail, `Your order #${order.id} has been confirmed`);
  },
  order_shipped: (message) => {
    const order = message;
    mail(order.customer.mail, `Your order #${order.id} has been shipped`);
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
