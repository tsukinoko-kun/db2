class DynamicGreeter {
  constructor() {
    let greeter = this;

    // proxy object will intercept missing method calls
    return new Proxy(this, {
      get: function (target, prop, receiver) {
        // method does not start with "greet_"
        if (!prop.startsWith("greet_")) {
          return Reflect.get(...arguments);
        }

        // we have already dynamically defined the method before
        if (greeter[prop]) {
          return Reflect.get(...arguments);
        }

        // define method
        greeter[prop] = function (message = "") {
          const name = prop.split("_")[1]; // Extracts the name part from prop
          return `Hello, ${
            name.charAt(0).toUpperCase() + name.slice(1)
          }! ${message}`;
        };

        // return
        return greeter[prop];
      },
    });
  }
}

const greeter = new DynamicGreeter();

// dynamically define and call
console.log(greeter.greet_bob());
// => "Hello, Bob! "

// dynamically define and call
console.log(greeter.greet_alice("How are you today?"));
// => "Hello, Alice! How are you today?"

// just call
console.log(greeter.greet_alice("How are you today?"));
// => "Hello, Alice! How are you today?"
