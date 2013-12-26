module GitDiff
  class LineNumber
    attr_reader :left, :right

    module ClassMethods
      def from_addition(line_number)
        new(nil, line_number.right).tap { line_number.increment_right }
      end

      def from_deletion(line_number)
        new(line_number.left, nil).tap { line_number.increment_left }
      end

      def from_line_number(line_number)
        new(line_number.left, line_number.right).tap { line_number.increment }
      end
    end
    extend ClassMethods

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
      increment_left
      increment_right
    end

    def pair
      [left, right]
    end
  end
end