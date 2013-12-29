module GitDiff
  module Range
    class Original < Base
      def to_s
        "-#{super}"
      end
    end
  end
end