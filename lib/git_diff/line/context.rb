module GitDiff
  module Line
    class Context < Base
      def line_number=(line_number)
        @line_number = LineNumber.for_context(line_number)
      end

      def context?
        true
      end
    end
  end
end
