module GitDiff
  class File

    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :hunks

    def self.from_string(string)
      if /^diff --git/.match(string)
        File.new
      end
    end

    def initialize
      @hunks = []
    end

    def <<(string)
      return if extract_diff_meta_data(string)

      if(range_info = RangeInfo.from_string(string))
        add_hunk Hunk.new(range_info)
      else
        append_to_current_hunk string
      end
    end

    def stats
      @stats ||= Stats.total(collector)
    end

    private

    attr_accessor :current_hunk

    # def collector
    #   ->(type) { hunks.map { |hunk| hunk.stats.total(type) } }
    # end

    def collector
      GitDiff::StatsCollector::Rollup.new(hunks)
    end

    def add_hunk(hunk)
      self.current_hunk = hunk
      hunks << current_hunk
    end

    def append_to_current_hunk(string)
      current_hunk << string
    end

    def extract_diff_meta_data(string)
      case
      when a_path_info = /^[-]{3} a\/(.*)$/.match(string)
        @a_path = a_path_info[1]
      when b_path_info = /^[+]{3} b\/(.*)$/.match(string)
        @b_path = b_path_info[1]
      when blob_info = /^index ([0-9A-Fa-f]+)\.\.([0-9A-Fa-f]+) ?(.+)?$/.match(string)
        @a_blob, @b_blob, @b_mode = *blob_info.captures
      end
    end
  end
end
