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
    size + 1
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
      size = fetch_sequence_size(number)
      update_biggest_sequence(number, size) if size > @biggest_sequence_size
    end
    print_message
  end

  private

  def fetch_sequence_size(number)
    @sequnce_size_cache[number] ||= CollatzSizeCalculator.new(number).sequence_size
  end

  def update_biggest_sequence(number, size)
    @biggest_sequence_number = number
    @biggest_sequence_size = size
  end

  def print_message
    "O inteiro com maior sequência é o #{@biggest_sequence_number} " \
      "com sequência contendo #{@biggest_sequence_size} elementos"
  end
end

# CollatzSizeCalculator.new(13).sequence_size
CollatzSizeComparator.new(100_000).biggest_sequence
