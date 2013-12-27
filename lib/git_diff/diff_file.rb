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

    def <<(string)
      return if extract_diff_meta_data(string)

      patch << string
    end

    def total_additions
      patch.additions.count
    end

    def total_deletions
      patch.deletions.count
    end

    private

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
