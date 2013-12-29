module GitDiff
  class Hunk
    include Enumerable
    extend Forwardable

    def_delegators :lines, :each

    attr_reader :lines, :old_range, :new_range, :header

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
      @header = header.strip
      @lines = []
    end

    def <<(string)
      Line.from_string(string, current_line_number).tap do |line|
        line_number_calculation.increment(line)
        lines << line
      end
    end

    def additions
      select(&:addition?)
    end

    def deletions
      select(&:deletion?)
    end

    private

    def current_line_number
      line_number_calculation.current
    end

    def initial_line_number
      @initial_line_number ||= LineNumber.new(old_range.start, new_range.start)
    end

    def line_number_calculation
      @line_number_calculation ||= LineNumberCalculation.new(initial_line_number)
    end
  end
end