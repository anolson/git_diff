module GitDiff
  class Line
    extend Forwardable

    def_delegators :content, :start_with?

    attr_reader :content
    attr_accessor :line_number

    def initialize(content)
      @content = content
      @line_number = nil
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
end
