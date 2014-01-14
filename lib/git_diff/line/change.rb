module GitDiff
  module Line
    module Change
      def from_string(string)
        new(string) if change?(string)
      end

      def change?(string)
        raise NotImplementedError.new("You must implement change?")
      end
    end
  end
end