require "git_diff/version"
require 'forwardable'

module GitDiff

  def self.from_string(string)
    parser = Parser.new(string)
    parser.parse
    parser.diff_files
  end

  class DiffFile
    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :patch

    def initialize
      @patch = Patch.new
    end

    def <<(line)
      return if extract_diff_meta_data(line)

      patch << Line.new(line)
    end

    def total_additions
      patch.additions.count
    end

    def total_deletions
      patch.deletions.count
    end

    private

    def extract_diff_meta_data(line)
      case
      when a_path_info = /^[-]{3} a\/(.*)$/.match(line)
        @a_path = a_path_info[1]
      when b_path_info = /^[+]{3} b\/(.*)$/.match(line)
        @b_path = b_path_info[1]
      when blob_info = /^index ([0-9A-Fa-f]+)\.\.([0-9A-Fa-f]+) ?(.+)?$/.match(line)
        @a_blob, @b_blob, @b_mode = *blob_info.captures
      end
    end
  end

  class Patch
    attr_reader :hunks

    def initialize
      @hunks = []
    end

    def <<(line)
      if(range_info = extract_hunk_range_info(line))
        add_hunk range_info
      else
        append_to_current_hunk line
      end
    end

    def count
      hunks.inject(0) { |count, hunk| count + hunk.count }
    end

    def additions
      hunks.map { |hunk| hunk.select(&:addition?) }.flatten
    end

    def deletions
      hunks.map { |hunk| hunk.select(&:deletion?) }.flatten
    end

    private

    attr_accessor :current_hunk

    def extract_hunk_range_info(line)
      /@@ \-(\d+,\d+) \+(\d+,\d+) @@(.*)/.match(line.to_s)
    end

    def add_hunk(range_info)
      self.current_hunk = Hunk.new(range_info)
      hunks << current_hunk
    end

    def append_to_current_hunk(line)
      current_hunk << line
    end
  end

  class Hunk
    include Enumerable
    extend Forwardable

    def_delegators :lines, :each, :<<

    attr_reader :lines, :old_range, :new_range, :header

    def initialize(range_info)
      @old_range = Range::Old.from_string(range_info[1])
      @new_range = Range::New.from_string(range_info[2])
      @header = range_info[3].strip
      @lines = []
    end
  end

  module Range
    class Base
      attr_reader :start, :number_of_lines

      def self.from_string(string)
        new(*string.split(","))
      end

      def initialize(start, number_of_lines)
        @start = start
        @number_of_lines = number_of_lines
      end

      def to_s
        "#{start},#{number_of_lines}"
      end
    end

    class Old < Base
      def to_s
        "-#{super}"
      end
    end

    class New < Base
      def to_s
        "+#{super}"
      end
    end
  end

  class Line
    extend Forwardable

    def_delegators :content, :start_with?

    attr_reader :content

    def initialize(content)
      @content = content
    end

    def addition?
      start_with?("+")
    end

    def deletion?
      start_with?("-")
    end

    def to_s
      content
    end
  end

  class Parser
    attr_reader :string, :diff_files

    def initialize(string)
      @string = string
      @diff_files = []
    end

    def parse
      lines.each do |line|
        if new_diff_file?(line)
          add_diff_file
        else
          append_to_current_diff_file line
        end
      end
    end

    private

    attr_accessor :current_diff_file

    def new_diff_file?(line)
      /^diff --git/.match(line)
    end

    def add_diff_file
      self.current_diff_file = DiffFile.new
      diff_files << current_diff_file
    end

    def append_to_current_diff_file(line)
      current_diff_file << line
    end

    def lines
      string.split("\n")
    end
  end
end