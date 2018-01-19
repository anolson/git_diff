module GitDiff
  class File

    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :hunks, :binary

    def self.from_string(string)
      if path_info = /^diff --git(?: a\/(\S+))?(?: b\/(\S+))?/.match(string)
        File.new(
          a_path: path_info.captures[0] || '/dev/null',
          b_path: path_info.captures[1] || '/dev/null'
        )
      end
    end

    def initialize(a_path: '/dev/null', b_path: '/dev/null')
      @hunks = []
      @a_path = a_path
      @b_path = b_path
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

    def collector
      GitDiff::StatsCollector::Rollup.new(hunks)
    end

    def add_hunk(hunk)
      self.current_hunk = hunk
      hunks << current_hunk
      @binary = false
    end

    def append_to_current_hunk(string)
      current_hunk << string
    end

    def extract_diff_meta_data(string)
      case
      when a_path_info = /^[-]{3} \/dev\/null(.*)$/.match(string)
        @a_path = "/dev/null"
      when a_path_info = /^[-]{3} a\/(.*)$/.match(string)
        @a_path = a_path_info[1]
      when b_path_info = /^[+]{3} \/dev\/null(.*)$/.match(string)
        @b_path = "/dev/null"
      when b_path_info = /^[+]{3} b\/(.*)$/.match(string)
        @b_path = b_path_info[1]
      when blob_info = /^index ([0-9A-Fa-f]+)\.\.([0-9A-Fa-f]+) ?(.+)?$/.match(string)
        @a_blob, @b_blob, @b_mode = *blob_info.captures
      when /^new file mode [0-9]{6}$/.match(string)
        @a_path = "/dev/null"
      when /^deleted file mode [0-9]{6}$/.match(string)
        @b_path = "/dev/null"
      when blob_info = /^(old|new) mode ([0-9]{6})$/.match(string)
        if blob_info.captures[0] == 'old'
          @a_mode = blob_info.captures[1]
        else
          @b_mode = blob_info.captures[1]
        end
      when binary_info = /^Binary files (?:\/dev\/null|a\/(.*)) and (?:\/dev\/null|b\/(.*)) differ$/.match(string)
        @binary = true
        @a_path ||= binary_info[1] || '/dev/null'
        @b_path ||= binary_info[2] || '/dev/null'
      end
    end
  end
end
