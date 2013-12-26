module GitDiff
  module Line
    class Addition < Base

      def initialize(content, line_number)
        super(content)
        @line_number = LineNumber.from_addition(line_number)
      end

      def addition?
        true
      end
    end
  end
end