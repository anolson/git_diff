# frozen_string_literal: true

module GitDiff
  class Stats
    attr_reader :number_of_additions, :number_of_lines, :number_of_deletions

    module ClassMethods
      def total(collector)
        StatsCalculator.new(collector).total
      end
    end
    extend ClassMethods

    def initialize(attributes)
      attributes.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end
  end
end
