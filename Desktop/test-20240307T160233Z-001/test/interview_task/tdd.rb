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
