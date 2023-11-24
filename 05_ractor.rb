require 'benchmark'

# Fibonacci sequence
class Fibonacci
  def self.of(n)
    return 0 if n == 0
    return 1 if n == 1

    of(n - 1) + of(n - 2)
  end
end

Benchmark.bm do |x|
  x.report('normal:') do
    5.times do
      Fibonacci.of(35)
    end
  end

  x.report('ractor:') do
    ractors = []
    5.times do
      ractors << Ractor.new do
        puts Process.pid
        Fibonacci.of(35)
      end
    end

    ractors.each(&:take)
  end
end
