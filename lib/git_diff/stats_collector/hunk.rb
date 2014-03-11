module GitDiff
  module StatsCollector
    class Hunk
      attr_reader :hunk

      def initialize(hunk)
        @hunk = hunk
      end

      def collect
        GitDiff::Stats.new(
          number_of_lines: number_of_lines,
          number_of_additions: number_of_additions,
          number_of_deletions: number_of_deletions
        )
      end

      private

      def number_of_lines
        lines.count
      end

      def number_of_additions
        lines.select(&:addition?).count
      end

      def number_of_deletions
        lines.select(&:deletion?).count
      end

      def lines
        hunk.lines
      end
    end

  end
end



