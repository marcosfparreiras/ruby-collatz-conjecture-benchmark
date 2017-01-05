require_relative 'result_printer'

class CollatzSizeComparatorWithCache
  def initialize(max_number)
    @max_number = max_number
    @numbers_sequence_size = {}
  end

  def biggest_sequence
    (1..@max_number).each do |number|
      calculate_sequence_size(number)
    end
    biggest = biggest_sequence_number
    ResultPrinter.new(biggest[:number], biggest[:size]).print
  end

  private

  def calculate_sequence_size(number)
    reference_number = number
    size = 0
    loop do
      if calculated?(number)
        size += @numbers_sequence_size[number]
        break
      end
      size += 1
      number = next_number(number)
      break if number == 1
    end
    @numbers_sequence_size[reference_number] = size
  end

  def calculated?(number)
    @numbers_sequence_size[number]
  end

  def next_number(number)
    return number / 2 if number.even?
    3 * number + 1
  end

  def biggest_sequence_number
    biggest = @numbers_sequence_size.max_by { |_k, v| v }
    { number: biggest[0], size: biggest[1] }
  end
end

if __FILE__ == $0
  puts CollatzSizeComparatorWithCache.new(1_000_000).biggest_sequence
end
