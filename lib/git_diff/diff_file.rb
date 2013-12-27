module GitDiff
  class DiffFile
    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :patch

    def self.from_string(string)
      if /^diff --git/.match(string)
        DiffFile.new
      end
    end

    def initialize
      @patch = Patch.new
    end

    def <<(line)
      return if extract_diff_meta_data(line)

      patch << line
    end

    def total_additions
      patch.additions.count
    end

    def total_deletions
      patch.deletions.count
    end

    private

    def extract_diff_meta_data(line)
      case
      when a_path_info = /^[-]{3} a\/(.*)$/.match(line)
        @a_path = a_path_info[1]
      when b_path_info = /^[+]{3} b\/(.*)$/.match(line)
        @b_path = b_path_info[1]
      when blob_info = /^index ([0-9A-Fa-f]+)\.\.([0-9A-Fa-f]+) ?(.+)?$/.match(line)
        @a_blob, @b_blob, @b_mode = *blob_info.captures
      end
    end
  end
end
