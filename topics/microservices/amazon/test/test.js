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

// subscribe to final order_shipped event
broker.subscribe("order_shipped");
broker.on("message", (topic, data) => {
  // parse message
  const message = JSON.parse(data.toString());
  console.log("message:", topic);
  console.log(message);
});

// create and publish a new order
const order = {
  id: 5,
  customer: {
    name: "Alice Doe",
    mail: "alice@doe.com",
  },
  address: {
    name: "Alice Doe",
    street: "Max-Planck-Straße 39",
    city: "74081 Heilbronn",
  },
  items: {
    book: {
      id: "book",
      title: "Microservices Book",
      price: 42.99,
    },
    adapter: {
      id: "adapter",
      title: "USB-C HDMI Adapter",
      price: 12.99,
    },
    powerbank: {
      id: "powerbank",
      title: "USB-C Powerbank 8000Ah",
      price: 28.99,
    },
  },
};
broker.publish("order_created", JSON.stringify(order), () => {
  console.log("published order");
});
