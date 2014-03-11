module GitDiff
  class LineNumberCalculation

    attr_reader :current

    def initialize(line_number)
      @current = line_number
    end

    def increment(line)
      line.line_number = current

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