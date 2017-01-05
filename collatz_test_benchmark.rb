require 'benchmark'
require_relative 'collatz_test'
require_relative 'collatz_test_cache'

class CollatzTestBenchmark
  def run
    print_results(collect_results)
  end

  private

  def collect_results
    (1..3).each_with_object([]) do |power, results|
      puts "Running test for size #{10**power}"
      results << benchmark_result(10**power)
    end
  end

  def benchmark_result(size)
    cache_benchmark =
      Benchmark.measure do
        ::CollatzSizeComparatorWithCache.new(size).biggest_sequence
      end

    simple_benchmark =
      Benchmark.measure do
        ::CollatzSizeComparator.new(size).biggest_sequence
      end

    {
      size: size,
      time_with_cache: cache_benchmark.real,
      time_without_cache: simple_benchmark.real
    }
  end

  def print_results(results)
    results.each do |result|
      puts '-----------------------------------'
      puts "Size: #{format_number(result[:size])}"
      puts "Code with cache time (s): #{result[:time_with_cache].round(5)}"
      puts "Code without cache time (s): #{result[:time_without_cache].round(5)}"
      puts
    end
  end

  def format_number(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

if __FILE__ == $0
  CollatzTestBenchmark.new.run
end
