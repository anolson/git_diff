require "test_helper"

class HunkTest < Minitest::Test

  def setup
    @range_info = GitDiff::RangeInfo.new("180,7", "180,7", "module Grit")
    @hunk = GitDiff::Hunk.new(@range_info)
  end

  def test_returns_an_enumerator_for_each_line
    assert_equal Enumerator, @hunk.each_line.class
  end

  def test_append_context_line
    @hunk << "some content"

    assert_equal 1, @hunk.stats.number_of_lines
  end

  def test_append_addition_line
    @hunk << "+ addition"

    assert_equal 1, @hunk.stats.number_of_additions
  end

  def test_append_deletion_line
    @hunk << "- deletion"

    assert_equal 1, @hunk.stats.number_of_deletions
  end
end
