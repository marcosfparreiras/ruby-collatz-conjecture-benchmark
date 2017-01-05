class ResultPrinter
  def initialize(number, size)
    @number = format_number(number)
    @size = size
  end

  def print
    "O inteiro com maior sequência é o #{@number} " \
      "com sequência contendo #{@size} elementos"
  end

  private

  def format_number(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end
