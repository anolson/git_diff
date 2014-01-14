require "test_helper"

class LineTest < MiniTest::Unit::TestCase

  def setup
    @line_number = GitDiff::LineNumber.new(0, 0)
  end


  def test_from_string_with_addition
    addition = GitDiff::Line.from_string("+ addition")

    refute_nil addition
    assert_instance_of GitDiff::Line::Addition, addition
  end

  def test_from_string_with_deletion
    deletion = GitDiff::Line.from_string("- deletion")

    refute_nil deletion
    assert_instance_of GitDiff::Line::Deletion, deletion
  end

  def test_from_string_with_context
    context = GitDiff::Line.from_string(" context")

    refute_nil context
    assert_instance_of GitDiff::Line::Context, context
  end
end