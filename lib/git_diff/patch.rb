module GitDiff
  class Patch
    attr_reader :hunks

    def initialize
      @hunks = []
    end

    def <<(line)
      if(range_info = extract_hunk_range_info(line))
        add_hunk range_info
      else
        append_to_current_hunk line
      end
    end

    def count
      hunks.inject(0) { |count, hunk| count + hunk.count }
    end

    def additions
      hunks.map { |hunk| hunk.select(&:addition?) }.flatten
    end

    def deletions
      hunks.map { |hunk| hunk.select(&:deletion?) }.flatten
    end

    private

    attr_accessor :current_hunk

    def extract_hunk_range_info(line)
      /@@ \-(\d+,\d+) \+(\d+,\d+) @@(.*)/.match(line.to_s)
    end

    def add_hunk(range_info)
      self.current_hunk = Hunk.new(range_info)
      hunks << current_hunk
    end

    def append_to_current_hunk(line)
      current_hunk << line
    end
  end
end
