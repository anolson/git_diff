    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :hunks, :binary
      @binary = false
      when binary_info = /^Binary files (?:\/dev\/null|a\/(.*)) and (?:\/dev\/null|b\/(.*)) differ$/.match(string)
        @binary = true
        @a_path ||= binary_info[1] || '/dev/null'
        @b_path ||= binary_info[2] || '/dev/null'