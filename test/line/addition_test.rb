require "test_helper"

class AdditionTest < Minitest::Test
  def setup
    @addition = GitDiff::Line::Addition.new("+ addition")
  end

  def test_addition_is_true
    assert @addition.addition?
  end

  def test_deletion_is_false
    refute @addition.deletion?
  end
end
