fib2 = nil

fib = Fiber.new do
  puts '1 - fib 01 started'
  fib2.transfer
  Fiber.yield
  puts '4 - fib 01 resumed'
end

fib2 = Fiber.new do
  puts '2 - control moved to fib2'
  fib.transfer
end

fib.resume
puts '3 - fib paused execution'
fib.resume
