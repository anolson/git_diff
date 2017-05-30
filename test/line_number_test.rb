require "test_helper"

class LineNumberTest < Minitest::Test

  def setup
    @line_number = GitDiff::LineNumber.new(0,0)
  end

  def test_increment_left
    @line_number.increment_left
    assert_equal 1, @line_number.left
    assert_equal 0, @line_number.right
  end

  def test_increment_right
    @line_number.increment_right
    assert_equal 0, @line_number.left
    assert_equal 1, @line_number.right
  end

  def test_increment
    @line_number.increment
    assert_equal 1, @line_number.left
    assert_equal 1, @line_number.right
  end

  def test_pair
    assert_equal [0,0], @line_number.pair
  end
end
