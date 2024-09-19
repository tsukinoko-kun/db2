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
  order_confirmed: (message) => {
    // save order
    const order = message;
    db.saveOrder(order);

    // publish pick event for each item
    for (const id in order.items) {
      const item = order.items[id];
      item.orderId = order.id;

      // simulate processing time
      setTimeout(() => {
        // publish
        broker.publish("warehouse_pick", JSON.stringify(item));
      }, parseInt(Math.random() * 1000));
    }
  },
  picking_completed: (message) => {
    const item = message;
    const order = db.findOrderById(item.orderId);

    // update item status
    order.items[item.id].status = "picked";
    db.saveOrder(order);

    // calculate picked items
    let total = Object.keys(order.items).length;
    let picked = 0;
    for (const id in order.items) {
      const item = order.items[id];
      if (item.status === "picked") {
        picked += 1;
      }
    }

    // if all items are picked, we can ship
    if (picked >= total) {
      // process payment
      const shipment = {
        orderId: order.id,
        type: "small_parcel",
        trackingId: "837hg73dh9chf83nd93j",
      };

      console.log("shipped:");
      console.log(shipment);

      // publish
      broker.publish("warehouse_shipped", JSON.stringify(shipment));
    }
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
