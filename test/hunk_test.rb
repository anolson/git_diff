require "test_helper"

class HunkTest < MiniTest::Unit::TestCase

  def setup
    @hunk = GitDiff::Hunk.new("-180,7", "+180,7", "module Grit")
  end

  def test_from_string_with_new_hunk
    hunk = GitDiff::Hunk.from_string "@@ -180,7 +180,7 @@ module Grit"

    refute_nil hunk
    assert_instance_of GitDiff::Hunk, hunk
  end

  def test_from_string_without_a_new_hunk
    hunk = GitDiff::Hunk.from_string "some other content"

    assert_nil hunk
  end


  def test_append_lines
    @hunk << "some content"

    assert_equal 1, @hunk.lines.count
  end

  def test_additions
    @hunk << "+ addition"

    assert_equal 1, @hunk.additions.count
  end


  def test_additions
    @hunk << "- deletion"

    assert_equal 1, @hunk.deletions.count
  end
end