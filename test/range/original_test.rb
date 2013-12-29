require "test_helper"

class OriginalTest < MiniTest::Unit::TestCase

  def test_to_s
    range = GitDiff::Range::Original.from_string("180,7")

    assert_equal "-180,7", range.to_s
  end
end