require "git_diff/line/base"
require "git_diff/line/addition"
require "git_diff/line/deletion"

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
  end
end