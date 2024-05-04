require 'debug'

class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiter = ','
    #for this condition ("//;\n1;2")
    if numbers.start_with?("//")
      delimiter = numbers[2] #delimiter = ;
      numbers = numbers.split("\n", 2).last
    end

    #this will seperate data with the help of split method using delimiter
    numbers = numbers.split(/#{delimiter}|\n/).map(&:to_i)

    #remove negative numbers if any and raise the error message
    negatives = numbers.select { |num| num < 0 }
    raise "Negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?

    numbers.inject(0, :+)
  end
end

# Example usage:
# calculator = StringCalculator.new
# puts calculator.add("")    # Output: 0
# puts calculator.add("1")   # Output: 1
# puts calculator.add("1,5") # Output: 6
# puts calculator.add("1\n2,3") # Output: 6
# puts calculator.add("//;\n1;2") # Output: 3
# puts calculator.add("1,-2,3")# This will raise an exception

require 'minitest/autorun'
class TestStringCalculator < Minitest::Test
  def setup
    @calculator = StringCalculator.new
  end

  def test_empty_string_returns_zero
    assert_equal 0, @calculator.add("")
  end

  def test_single_number_returns_number
    assert_equal 1, @calculator.add("1")
  end

  def test_two_numbers_returns_sum
    assert_equal 6, @calculator.add("1,5")
  end

  def test_multiple_numbers_returns_sum
    assert_equal 6, @calculator.add("1\n2,3")
  end

  def test_custom_delimiter_returns_sum
    assert_equal 3, @calculator.add("//;\n1;2")
  end

  def test_negative_numbers_raise_exception
    assert_raises(RuntimeError) { @calculator.add("-1,2") }
  end

  def test_negative_numbers_exception_message
    exception = assert_raises(RuntimeError) { @calculator.add("-1,2,-3") }
    assert_equal "Negative numbers not allowed: -1, -3", exception.message
  end
end