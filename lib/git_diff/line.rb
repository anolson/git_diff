module GitDiff
  class Line
    extend Forwardable

    def_delegators :content, :start_with?

    attr_reader :content, :line_number

    def initialize(content, line_number)
      @content = content
      set_line_number(line_number)
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

    private

    def set_line_number(line_number)
      case
      when addition?
        @line_number = LineNumber.from_addition(line_number)
      when deletion?
        @line_number = LineNumber.from_deletion(line_number)
      else
        @line_number = LineNumber.from_line_number(line_number)
      end
    end
  end
end
