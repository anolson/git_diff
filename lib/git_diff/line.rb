require "git_diff/line/context"
require "git_diff/line/change"
require "git_diff/line/addition"
require "git_diff/line/deletion"

module GitDiff
  module Line
    module ClassMethods
      def from_string(string, line_number)
        Addition.from_string(string, line_number) ||
        Deletion.from_string(string, line_number) ||
        Context.new(string, line_number)
      end
    end
    extend ClassMethods
  end
end