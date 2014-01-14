require "test_helper"

class DeletionTest < MiniTest::Unit::TestCase
  def setup
    @deletion = GitDiff::Line::Deletion.new("- deletion")
  end

  def test_addition_is_false
    refute @deletion.addition?
  end

  def test_deletion_is_true
    assert @deletion.deletion?
  end
end