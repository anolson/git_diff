require "test_helper"

class LineNumberCalculationTest < MiniTest::Unit::TestCase

  def setup
    @line_number = GitDiff::LineNumber.new(0, 0)
    @line_number_calculation = GitDiff::LineNumberCalculation.new(@line_number)

    @addition = GitDiff::Line::Addition.new("+ addition", @line_number)
    @deletion = GitDiff::Line::Deletion.new("- deletion", @line_number)
    @context = GitDiff::Line::Context.new(" context", @line_number)
  end

  def test_increment_with_addition_line
    @line_number_calculation.increment(@addition)

    assert_equal 0, @line_number_calculation.current.left
    assert_equal 1, @line_number_calculation.current.right
  end

  def test_increment_with_deletion_line
    @line_number_calculation.increment(@deletion)

    assert_equal 1, @line_number_calculation.current.left
    assert_equal 0, @line_number_calculation.current.right
  end

  def test_increment_with_context_line
    @line_number_calculation.increment(@context)

    assert_equal 1, @line_number_calculation.current.left
    assert_equal 1, @line_number_calculation.current.right
  end
end