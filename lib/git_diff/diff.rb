# frozen_string_literal: true

module GitDiff
  class Diff
    attr_reader :files

    def initialize
      @files = []
    end

    def <<(string)
      if file = File.from_string(string)
        add_file file
      else
        append_to_current_file string
      end
    end

    def stats
      @stats ||= Stats.total(collector)
    end

    private

    def collector
      GitDiff::StatsCollector::Rollup.new(files)
    end

    attr_accessor :current_file

    def add_file(file)
      self.current_file = file
      files << current_file
    end

    def append_to_current_file(line)
      current_file << line
    end
  end
end
