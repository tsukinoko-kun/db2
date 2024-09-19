def request
  File.read("readme.txt")
end

# trigger request and expect a response
response = request

puts(response)