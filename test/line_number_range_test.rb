require "test_helper"

class LineNumberRangeTest < MiniTest::Unit::TestCase

  def test_from_string_with_empty_string
    range = GitDiff::LineNumberRange.from_string("")

    assert_equal 0, range.start
    assert_equal 0, range.number_of_lines
  end

  def test_from_string_with_empty_string
    range = GitDiff::LineNumberRange.from_string("180,7")

    assert_equal 180, range.start
    assert_equal 7, range.number_of_lines
  end

  def test_to_s
    range = GitDiff::LineNumberRange.from_string("180,7")

    assert_equal "+180,7", range.to_s(:+)
  end
end