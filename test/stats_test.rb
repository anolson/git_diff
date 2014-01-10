require "test_helper"

class ShamaLamaDingDong
  attr_reader :total_number_of_additions, :total_number_of_deletions, :total_number_of_lines

  def initialize(additions, deletions, lines)
    @total_number_of_additions = additions
    @total_number_of_deletions = deletions
    @total_number_of_lines = lines
  end
end

class StatsTest < MiniTest::Unit::TestCase
  def setup
    shamalamadingdongs = [
      ShamaLamaDingDong.new(1, 4, 7),
      ShamaLamaDingDong.new(2, 5, 8),
      ShamaLamaDingDong.new(3, 6, 9)
    ]

    @stats = GitDiff::Stats.new(shamalamadingdongs)
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