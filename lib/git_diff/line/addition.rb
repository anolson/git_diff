module GitDiff
  module Line
    class Addition < Context

      def self.from_string(string, line_number)
        new(string, line_number) if string.start_with?("+")
      end

      def initialize(content, line_number)
        super(content, line_number)
        @line_number = LineNumber.from_addition(line_number)
      end

      def addition?
        true
      end
    end
  end
end