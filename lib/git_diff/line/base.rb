module GitDiff
  module Line

    module ClassMethods
      def from_string(string, line_number)
        case
        when string.start_with?("+")
          Addition.new(string, line_number)
        when string.start_with?("-")
          Deletion.new(string, line_number)
        else
          Base.new(string, line_number)
        end
      end
    end
    extend ClassMethods

    class Base
      attr_reader :content, :line_number

      def initialize(content, line_number=nil)
        @content = content
        @line_number = LineNumber.from_line_number(line_number) if line_number
      end

      def deletion?
        false
      end

      def addition?
        false
      end

      def to_s
        content
      end
    end
  end
end
