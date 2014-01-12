module GitDiff
  class Stats
    attr_reader :collector

    def initialize(collector)
      @collector = collector
    end

    def total(type)
      public_send("total_#{type}")
    end

    def total_number_of_additions
      calculate_total :number_of_additions
    end

    def total_number_of_lines
      calculate_total :number_of_lines
    end

    def total_number_of_deletions
      calculate_total :number_of_deletions
    end

    private

    def calculate_total(type)
      collect_stats(type).inject(:+)
    end

    def collect_stats(type)
      if collector.respond_to?(:call)
        collector.call(type)
      else
        collector.public_send(type)
      end
    end
  end
end