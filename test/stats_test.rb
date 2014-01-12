require "test_helper"

class Collector
  def number_of_additions
    [1, 2, 3]
  end

  def number_of_deletions
    [4, 5, 6]
  end

  def number_of_lines
    [7, 8, 9]
  end
end

class StatsTest < MiniTest::Unit::TestCase
  def setup
    collector = Collector.new

    @stats = GitDiff::Stats.new(collector)
  end

  def test_total_number_additions_is_the_sum_of_all_the_additions
    assert_equal 6, @stats.total_number_of_additions
  end

  def test_total_number_additions_is_the_sum_of_all_the_deletions
    assert_equal 15, @stats.total_number_of_deletions
  end

  def test_total_number_additions_is_the_sum_of_all_the_lines
    assert_equal 24, @stats.total_number_of_lines
  end
end