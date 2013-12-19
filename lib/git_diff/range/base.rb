module GitDiff
  module Range
    class Base
      attr_reader :start, :number_of_lines

      def self.from_string(string)
        new(*string.split(","))
      end

      def initialize(start, number_of_lines)
        @start = start
        @number_of_lines = number_of_lines
      end

      def to_s
        "#{start},#{number_of_lines}"
      end
    end
  end
end