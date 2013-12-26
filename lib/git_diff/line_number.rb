module GitDiff
  class LineNumber
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def increment_left
      @left += 1
    end

    def increment_right
      @right += 1
    end

    def increment
      @left += 1
      @right += 1
    end

    def pair
      [left, right]
    end
  end
end