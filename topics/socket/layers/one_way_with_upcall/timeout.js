function sayHello() {
  console.log("Hello, I was called from a lower layer!")
}

console.log("Started")

// pass handler to function
setTimeout(sayHello, 2000)