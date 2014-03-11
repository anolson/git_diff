module GitDiff
  module StatsCollector
    class StatsCollector::Rollup
      attr_reader :collection

      def initialize(collection)
        @collection = collection
      end

      def collect
        collection.map { |item| item.stats }
      end
    end
  end
end
