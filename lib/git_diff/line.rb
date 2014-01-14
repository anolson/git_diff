require "git_diff/line/context"
require "git_diff/line/addition"
require "git_diff/line/deletion"

module GitDiff
  module Line
    module ClassMethods
      def from_string(string)
        line_class(string[0]).new(string)
      end

      def line_class(symbol)
        line_classes[symbol] || Context
      end

      def line_classes
        { "+" => Addition, "-" => Deletion }
      end
    end
    extend ClassMethods
  end
end