require "forwardable"


require "git_diff/diff"
require "git_diff/file"
require "git_diff/hunk"
require "git_diff/hunk_stats_collector"
require "git_diff/line"
require "git_diff/line_number"
require "git_diff/line_number_calculation"
require "git_diff/line_number_range"
require "git_diff/parser"
require "git_diff/range_info"
require "git_diff/stats"
require "git_diff/version"

module GitDiff
  def self.from_string(string)
    parser = Parser.new(string)
    parser.parse
    parser.diff
  end
end