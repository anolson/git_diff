# frozen_string_literal: true

require "test_helper"

class Collector
  def collect
    GitDiff::Stats.new(
      number_of_lines: number_of_lines,
      number_of_additions: number_of_additions,
      number_of_deletions: number_of_deletions
    )
  end

  private

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

class StatsCalculatorTest < Minitest::Test
  def setup
    collector = Collector.new

    calculator = GitDiff::StatsCalculator.new(collector)
    @stats = calculator.total
  end

  def test_total_number_additions_is_the_sum_of_all_the_additions
    assert_equal 6, @stats.number_of_additions
  end

  def test_total_number_additions_is_the_sum_of_all_the_deletions
    assert_equal 15, @stats.number_of_deletions
  end

  def test_total_number_additions_is_the_sum_of_all_the_lines
    assert_equal 24, @stats.number_of_lines
  end
end
