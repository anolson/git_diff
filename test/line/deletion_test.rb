require "test_helper"

class DeletionTest < Minitest::Test
  def setup
    @deletion = GitDiff::Line::Deletion.new("- deletion")
  end

  def test_addition_is_false
    refute @deletion.addition?
  end

  def test_context_is_false
    refute @deletion.context?
  end

  def test_deletion_is_true
    assert @deletion.deletion?
  end
end
