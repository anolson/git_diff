module GitDiff
  module Range
    class New < Base
      def to_s
        "+#{super}"
      end
    end
  end
end