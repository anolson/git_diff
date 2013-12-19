module GitDiff
  module Range
    class Old < Base
      def to_s
        "-#{super}"
      end
    end
  end
end