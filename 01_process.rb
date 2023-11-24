require 'benchmark'

# Fibonacci sequence
class Fibonacci
  def self.of(n)
    return 0 if n == 0
    return 1 if n == 1

    of(n - 1) + of(n - 2)
  end
end

# Benchmark.bm do |x|
#   x.report('Normal:') do
#     5.times do
#       Fibonacci.of(35)
#     end
#   end

#   x.report('Process:') do
#     pids = []
#     5.times do
#       pids << fork do
#         Fibonacci.of(35)
#       end
#     end

#     pids.each { |pid| Process.wait(pid) }
#   end
# end

# Testing how processes share memory
class ProcessAccess
  def self.run
    sum = 0
    pids = []

    5.times do
      pids << fork do
        sum += 1
      end
    end

    pids.each { |pid| Process.wait(pid) }

    puts "Sum: #{sum}"
  end
end

ProcessAccess.run
