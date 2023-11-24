require 'benchmark'
require 'open-uri'

# Fibonacci sequence
class Fibonacci
  def self.of(n)
    return 0 if n == 0
    return 1 if n == 1

    of(n - 1) + of(n - 2)
  end
end

Benchmark.bm do |x|
  x.report('Fibonacci:') do
    threads = []
    5.times do
      threads << Thread.new do
        Fibonacci.of(35)
      end
    end

    threads.each(&:join)
  end

  x.report('URI no threads:') do
    5.times do
      URI.open('https://httpbin.org/delay/1')
    end
  end

  x.report('URI with threads:') do
    threads = []
    5.times do
      threads << Thread.new do
        URI.open('https://httpbin.org/delay/1')
      end
    end

    threads.each(&:join)
  end
end

class ThreadWithoutMutex
  def self.run
    a = 0
    sum = 0
    threads = []

    # Expect: 1 + 2 + 3 = 6
    # Got: (1 + 1) + (2 + 1) + (3 + 1) = 9
    10_000.times do
      threads << Thread.new do
        a += 1
        sleep 1
        sum += a
      end
    end
    threads.each(&:join)
    puts "calculation without mutex - sum #{sum}"
  end
end

class ThreadWithMutex
  def self.run
    a = 0
    sum = 0
    mutex = Thread::Mutex.new
    threads = []

    3.times do
      threads << Thread.new do
        mutex.synchronize do
          a += 1
          sleep 1
          sum += a
        end
      end
    end
    threads.each(&:join)
    puts "calculation with mutex - sum #{sum}"
  end
end


# Uncomment to run
# ThreadWithoutMutex.run
# ThreadWithMutex.run
