module GitDiff
  class Hunk
    include Enumerable
    extend Forwardable

    def_delegators :lines, :each, :<<

    attr_reader :lines, :old_range, :new_range, :header

    def self.from_string(string)
      if(range_data = extract_hunk_range_data(string))
        Hunk.new(*range_data.captures)
      end
    end

    def self.extract_hunk_range_data(string)
      /@@ \-(\d+,\d+) \+(\d+,\d+) @@(.*)/.match(string)
    end

    def initialize(old_range, new_range, header)
      @old_range = Range::Old.from_string(old_range)
      @new_range = Range::New.from_string(new_range)
      @header = header.strip
      @lines = []
    end

    def additions
      select(&:addition?)
    end

    def deletions
      select(&:deletion?)
    end
  end
end