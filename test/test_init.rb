ENV["CONSOLE_DEVICE"] ||= "stdout"
ENV["LOG_TAGS"] ||= "_all,_untagged"
ENV["LOG_LEVEL"] ||= "_min"

ENV["TEST_BENCH_DETAIL"] ||= ENV["D"]

puts RUBY_DESCRIPTION

require_relative "../init.rb"

require "test_bench"; TestBench.activate
require "securerandom"
require "pp"

require "record_invocation/controls"
