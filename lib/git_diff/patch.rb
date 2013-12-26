module GitDiff
  class Patch
    attr_reader :hunks

    def initialize
      @hunks = []
    end

    def <<(line)
      if(hunk = Hunk.from_string(line))
        add_hunk hunk
      else
        append_to_current_hunk line
      end
    end

    def count
      hunks.inject(0) { |count, hunk| count + hunk.count }
    end

    def additions
      hunks.map { |hunk| hunk.additions }.flatten
    end

    def deletions
      hunks.map { |hunk| hunk.deletions }.flatten
    end

    private

    attr_accessor :current_hunk

    def add_hunk(hunk)
      self.current_hunk = hunk
      hunks << current_hunk
    end

    def append_to_current_hunk(line)
      current_hunk << line
    end
  end
end
