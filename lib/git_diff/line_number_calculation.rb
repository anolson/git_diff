module GitDiff
  class LineNumberCalculation

    attr_reader :current

    def initialize(left_start, right_start)
      @current = LineNumber.new(left_start, right_start)
    end

    def increment(line)
      if line.addition?
        current.increment_right
      elsif line.deletion?
        current.increment_left
      else
        current.increment
      end
    end
  end
end