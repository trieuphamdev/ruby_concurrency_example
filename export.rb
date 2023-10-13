require 'wicked_pdf'
require 'erb'
require 'benchmark'

def api
  sleep 2
  "API"
end

def db
  sleep 3
  "DB"
end

def template
  ERB.new <<-EOF
    <%= api %>
    <%= db %>
  EOF
end

puts Benchmark.measure { WickedPdf.new.pdf_from_string(template.result(binding)) }
