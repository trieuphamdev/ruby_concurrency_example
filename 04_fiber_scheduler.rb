require 'fiber_scheduler'
require 'benchmark'
require 'open-uri'

Benchmark.bm do |x|
  x.report('API normal') do
    5.times do
      URI.open('https://httpbin.org/delay/1')
    end
  end

  x.report('API Fiber:') do
    Thread.new do
      Fiber.set_scheduler(FiberScheduler.new)
      5.times do
        Fiber.schedule do
          URI.open('https://httpbin.org/delay/1')
        end
      end
    end.join
  end

  x.report('System sleep:') do
    Thread.new do
      Fiber.set_scheduler(FiberScheduler.new)
      10_000.times do
        Fiber.schedule do
          sleep 2
        end
      end
    end.join
  end
end

# Stimulate web crawler
class Crawler
  def self.run
    results = []
    Thread.new do
      Fiber.set_scheduler(FiberScheduler.new)
      5.times do
        Fiber.schedule do
          results << URI.open('https://httpbin.org/delay/1')
        end
      end
    end.join
  end
end

# Uncomment to run
# Crawler.run
