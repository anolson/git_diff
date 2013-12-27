module GitDiff
  class Parser
    attr_reader :string, :diff_files

    def initialize(string)
      @string = string
      @diff_files = []
    end

    def parse
      lines.each do |line|
        if diff_file = DiffFile.from_string(line)
          add_diff_file diff_file
        else
          append_to_current_diff_file line
        end
      end
    end

    private

    attr_accessor :current_diff_file

    def add_diff_file(diff_file)
      self.current_diff_file = diff_file
      diff_files << current_diff_file
    end

    def append_to_current_diff_file(line)
      current_diff_file << line
    end

    def lines
      string.split("\n")
    end
  end
end
