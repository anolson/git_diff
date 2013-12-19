require "git_diff/diff_file"
require "git_diff/hunk"
require "git_diff/line"
require "git_diff/parser"
require "git_diff/patch"
require "git_diff/range"
require "git_diff/version"

module GitDiff
  def self.from_string(string)
    parser = Parser.new(string)
    parser.parse
    parser.diff_files
  end
end