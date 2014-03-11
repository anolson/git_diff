require "test_helper"

class AdditionTest < MiniTest::Unit::TestCase
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