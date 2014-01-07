module GitDiff
  class RangeInfo
    attr_reader :original_range, :new_range, :header

    module ClassMethods
      def from_string(string)
        if(range_data = extract_hunk_range_data(string))
          new(*range_data.captures)
        end
      end

      def extract_hunk_range_data(string)
        /@@ \-(\d+,\d+) \+(\d+,\d+) @@(.*)/.match(string)
      end
    end
    extend ClassMethods

    def initialize(original_range, new_range, header)
      @original_range = LineNumberRange.from_string(original_range)
      @new_range = LineNumberRange.from_string(new_range)
      @header = header.strip
    end

    def to_s
      "@@ #{original_range.to_s(:-)} #{new_range.to_s(:+)} @@ #{header}".strip
    end
  end
end