module GitDiff
  module Line
    class Deletion < Base

      def initialize(content, line_number)
        super(content)
        @line_number = LineNumber.from_deletion(line_number)
      end

      def deletion?
        true
      end
    end
  end
end