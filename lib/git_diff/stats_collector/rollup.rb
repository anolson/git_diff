# frozen_string_literal: true

module GitDiff
  module StatsCollector
    class StatsCollector::Rollup
      attr_reader :collection

      def initialize(collection)
        @collection = collection
      end

      def collect
        collection.map(&:stats)
      end
    end
  end
end
