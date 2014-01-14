module GitDiff
  module Line
    class Deletion < Context
      extend GitDiff::Line::Change

      def self.change?(string)
        string.start_with?("-")
      end

      def line_number=(line_number)
        @line_number = LineNumber.for_deletion(line_number)
      end

      def deletion?
        true
      end
    end
  end
end