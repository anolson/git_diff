module GitDiff
  module Range
    class Base
      attr_reader :start, :number_of_lines

      def self.from_string(string)
        new(*string.split(","))
      end

      def initialize(start = 0, number_of_lines = 0)
        @start = start.to_i
        @number_of_lines = number_of_lines.to_i
      end

      def to_s
        "#{start},#{number_of_lines}"
      end
    end
  end
end