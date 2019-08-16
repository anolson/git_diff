# frozen_string_literal: true

module GitDiff
  class Parser
    attr_reader :string, :diff

    def initialize(string)
      @string = string
      @diff = Diff.new
    end

    def parse
      lines.each do |line|
        diff << line
      end
    end

    private

    def lines
      string.split("\n")
    end
  end
end
