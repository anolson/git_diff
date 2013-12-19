module GitDiff
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
end