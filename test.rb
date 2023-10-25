require 'benchmark'

def factorial(n)
  n == 0 ? 1 : n * factorial(n - 1)
end


Benchmark.bmbm(10) do |x|
  x.report('normal:') do
    4.times do
      1000.times { factorial(2000) }
    end
  end

  x.report('processes:') do
    pids = []
    4.times do
      pids << fork do
        1000.times { factorial(1000) }
      end
    end
    # wait for child procceses to exit
    pids.each { |pid| Process.wait(pid) }
  end

  x.report('threads:') do
    threads = []
    4.times do
      threads << Thread.new do
        1000.times { factorial(1000) }
      end
    end
    # wait for all thread to finish using join method
    threads.each(&:join)
  end
end
