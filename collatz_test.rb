require_relative 'result_printer'

class CollatzSizeCalculator
  def initialize(starting_number)
    @starting_number = starting_number
  end

  def sequence_size
    size = 0
    number = @starting_number
    loop do
      size += 1
      number = next_number(number)
      break if number == 1
    end
    size
  end

  private

  def next_number(number)
    return number/2 if number.even?
    3 * number + 1
  end
end

class CollatzSizeComparator
  def initialize(max_number)
    @max_number = max_number
    @biggest_sequence_number = 0
    @biggest_sequence_size = 0
    @sequnce_size_cache = {}
  end

  def biggest_sequence
    (1..@max_number).each do |number|
      size = CollatzSizeCalculator.new(number).sequence_size
      update_biggest_sequence(number, size) if size > @biggest_sequence_size
    end
    ResultPrinter.new(@biggest_sequence_number, @biggest_sequence_size).print
  end

  private

  def update_biggest_sequence(number, size)
    @biggest_sequence_number = number
    @biggest_sequence_size = size
  end
end

if __FILE__ == $0
  puts CollatzSizeComparator.new(1_000_000).biggest_sequence
end
