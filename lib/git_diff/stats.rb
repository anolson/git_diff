module GitDiff
  class Stats
    attr_reader :collection

    def initialize(collection)
      @collection = collection
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
      collection.inject(0) { |sum, item| sum += item.send("total_#{type}") }
    end
  end
end