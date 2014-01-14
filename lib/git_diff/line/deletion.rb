module GitDiff
  module Line
    class Deletion < Context
      def line_number=(line_number)
        @line_number = LineNumber.for_deletion(line_number)
      end

      def deletion?
        true
      end
    end
  end
end