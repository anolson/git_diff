module GitDiff
  class LineNumberRange
    attr_reader :start, :number_of_lines

    def self.from_string(string)
      new(*string.split(","))
    end

    def initialize(start = 0, number_of_lines = 1)
      @start = start.to_i
      @number_of_lines = number_of_lines.to_i
    end

    def to_s(type)
      "#{type}#{start},#{number_of_lines}"
    end
  end
end