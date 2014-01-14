require "git_diff/line/context"
require "git_diff/line/change"
require "git_diff/line/addition"
require "git_diff/line/deletion"

module GitDiff
  module Line
    module ClassMethods
      def from_string(string)
        Addition.from_string(string) ||
        Deletion.from_string(string) ||
        Context.new(string)
      end
    end
    extend ClassMethods
  end
end