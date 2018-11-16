module GitDiff
  module Line
    class Addition < Base
      def line_number=(line_number)
        @line_number = LineNumber.for_addition(line_number)
      end

      def addition?
        true
      end
    end
  end
end