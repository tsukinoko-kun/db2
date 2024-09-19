const mqtt = require("mqtt");
const broker = mqtt.connect("mqtt://mosquitto");
const db = require("./db.js");

// print connected message
broker.on("connect", () => {
  console.log("connected: mqtt://mosquitto");
});

// print error message
broker.on("error", (err) => {
  console.error(err);
});

const handlers = {
  order_created: (message) => {
    // save order
    const order = message;
    order.status = "placed";
    db.saveOrder(order);

    console.log("placed:");
    console.log(order);

    // publish
    broker.publish("order_placed", JSON.stringify(order));
  },
  payment_processed: (message) => {
    // find order
    const payment = message;
    const order = db.findOrderById(payment.orderId);

    // update order
    order.payment = payment;
    order.status = "confirmed";
    db.saveOrder(order);

    // publish
    broker.publish("order_confirmed", JSON.stringify(order));
  },
  warehouse_shipped: (message) => {
    // find order
    const shipment = message;
    const order = db.findOrderById(shipment.orderId);

    // update order
    order.shipment = shipment;
    order.status = "shipped";
    db.saveOrder(order);

    // publish
    broker.publish("order_shipped", JSON.stringify(order));
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
