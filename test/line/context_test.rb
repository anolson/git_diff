require "test_helper"

class ContextTest < MiniTest::Unit::TestCase
  def setup
    @line_number = GitDiff::LineNumber.new(0,0)
    @content = "some content"
    @context = GitDiff::Line::Context.new(@content, @line_number)
  end

  def test_addition_is_false
    refute @context.addition?
  end

  def test_deletion_is_false
    refute @context.deletion?
  end

  def test_to_s_returns_the_content
    assert_equal @content, @context.to_s
  end
end