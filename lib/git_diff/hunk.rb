require "forwardable"

module GitDiff
  class Hunk
    include Enumerable
    extend Forwardable

    def_delegators :lines, :each

    attr_reader :lines, :range_info

    def initialize(range_info)
      @range_info = range_info
      @lines = []
    end

    def <<(string)
      Line.from_string(string).tap do |line|
        line_number_calculation.increment(line)
        lines << line
      end
    end

    def stats
      @stats ||= Stats.total(collector)
    end

    private

    def collector
      GitDiff::StatsCollector::Hunk.new(self)
    end

    def initial_line_number
      @initial_line_number ||= LineNumber.new(range_info.original_range.start, range_info.new_range.start)
    end

    def line_number_calculation
      @line_number_calculation ||= LineNumberCalculation.new(initial_line_number)
    end
  end
end