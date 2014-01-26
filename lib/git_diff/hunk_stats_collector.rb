module GitDiff
  class HunkStatsCollector
    attr_reader :hunk

    def initialize(hunk)
      @hunk = hunk
    end

    def number_of_lines
      lines.count
    end

    def number_of_additions
      lines.select(&:addition?).count
    end

    def number_of_deletions
      lines.select(&:deletion?).count
    end

    private

    def lines
      hunk.lines
    end
  end
end



