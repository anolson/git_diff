require "test_helper"

class RangeInfoTest < MiniTest::Unit::TestCase
  def setup
    @range_info = GitDiff::RangeInfo.new("180,7", "180,7", "module Grit")
  end

  def test_from_string
    range_info = GitDiff::RangeInfo.from_string("@@ -180,7 +180,7 @@")

    refute_nil range_info
    assert_instance_of GitDiff::RangeInfo, range_info
  end

  def test_from_string_with_header
    range_info = GitDiff::RangeInfo.from_string("@@ -180,7 +180,7 @@ module Grit")

    refute_nil range_info
    assert_instance_of GitDiff::RangeInfo, range_info
  end

  def test_with_incomplete_range_info
    range_info = GitDiff::RangeInfo.from_string("@@ -1 +1,2 @@")

    refute_nil range_info
    assert_instance_of GitDiff::RangeInfo, range_info
  end

  def test_to_s
    assert_equal "@@ -180,7 +180,7 @@ module Grit", @range_info.to_s
  end
end
