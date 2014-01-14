require "test_helper"

class AdditionTest < MiniTest::Unit::TestCase
  def setup
    @addition = GitDiff::Line::Addition.new("+ addition")
  end

  def test_from_string_with_an_addition
    addition = GitDiff::Line::Addition.from_string("+ addition")

    refute_nil addition
    assert_instance_of GitDiff::Line::Addition, addition
  end

  def test_from_string_without_an_addition
    assert_nil GitDiff::Line::Addition.from_string("addition")
  end

  def test_addition_is_true
    assert @addition.addition?
  end

  def test_deletion_is_false
    refute @addition.deletion?
  end
end