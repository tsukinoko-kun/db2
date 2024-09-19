// indexes
const orderById = {};

exports.saveOrder = (order) => {
  orderById[order.id] = order;
};

exports.findOrderById = (id) => {
  return orderById[id];
};
