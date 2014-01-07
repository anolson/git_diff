require "test_helper"

class HunkTest < MiniTest::Unit::TestCase

  def setup
    @range_info = GitDiff::RangeInfo.new("180,7", "180,7", "module Grit")
    @hunk = GitDiff::Hunk.new(@range_info)
  end

  def test_append_context_line
    @hunk << "some content"

    assert_equal 1, @hunk.lines.count
  end

  def test_append_addition_line
    @hunk << "+ addition"

    assert_equal 1, @hunk.additions.count
  end

  def test_append_deletion_line
    @hunk << "- deletion"

    assert_equal 1, @hunk.deletions.count
  end
end