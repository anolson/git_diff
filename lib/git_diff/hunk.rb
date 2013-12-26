module GitDiff
  class Hunk
    include Enumerable
    extend Forwardable

    def_delegators :lines, :each

    attr_reader :lines, :old_range, :new_range, :header, :current_line_number

    module ClassMethods
      def from_string(string)
        if(range_data = extract_hunk_range_data(string))
          Hunk.new(*range_data.captures)
        end
      end

      def extract_hunk_range_data(string)
        /@@ \-(\d+,\d+) \+(\d+,\d+) @@(.*)/.match(string)
      end
    end
    extend ClassMethods

    def initialize(old_range, new_range, header)
      @old_range = Range::Old.from_string(old_range)
      @new_range = Range::New.from_string(new_range)

      @current_line_number = LineNumber.new(@old_range.start, @new_range.start)

      @header = header.strip
      @lines = []
    end

    def <<(string)
      lines << Line.new(string, current_line_number)
    end

    def additions
      select(&:addition?)
    end

    def deletions
      select(&:deletion?)
    end
  end
end