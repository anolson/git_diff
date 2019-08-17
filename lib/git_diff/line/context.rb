# frozen_string_literal: true

module GitDiff
  module Line
    class Context
      attr_reader :content, :line_number

      def initialize(content, line_number = nil)
        @content = content
        @line_number = line_number
      end

      def line_number=(line_number)
        @line_number = LineNumber.for_context(line_number)
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
