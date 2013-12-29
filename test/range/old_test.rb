require "test_helper"

class NewTest < MiniTest::Unit::TestCase

  def test_to_s
    range = GitDiff::Range::Old.from_string("180,7")

    assert_equal "-180,7", range.to_s
  end
end