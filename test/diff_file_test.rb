require "test_helper"

class DiffFileTest < MiniTest::Unit::TestCase

  def setup
    @diff_file = GitDiff::DiffFile.new
  end

  def test_from_string_with_a_diff
    diff_file = GitDiff::DiffFile.from_string "diff --git"

    refute_nil diff_file
    assert_instance_of GitDiff::DiffFile, diff_file
  end

  def test_from_string_without_a_diff
    diff_file = GitDiff::DiffFile.from_string ""

    assert_nil diff_file
  end

  def test_blob_data_is_correctly_extracted
    @diff_file << "index 033b446..0e2d140 100644"

    assert_equal "033b446", @diff_file.a_blob
    assert_equal "0e2d140", @diff_file.b_blob
  end

  def test_mode_data_is_correctly_extracted
    @diff_file << "index 033b446..0e2d140 100644"

    assert_equal "100644", @diff_file.b_mode
  end

  def test_paths_are_correctly_extracted
    @diff_file << "--- a/lib/grit/repo.rb"
    @diff_file << "+++ b/lib/grit/repo.rb"

    assert_equal "lib/grit/repo.rb", @diff_file.a_path
    assert_equal "lib/grit/repo.rb", @diff_file.b_path
  end

  def test_appending_a_hunk
    @diff_file << "@@ -180,7 +180,7 @@ module Grit"
    @diff_file << "       io = StringIO.new(text)"
    @diff_file << "       objects = []"
    @diff_file << "       while line = io.gets"
    @diff_file << "-        sha, type, size = line.split(" ", 3)"
    @diff_file << "+        sha, type, size = line.split(" ", 3) #wut"
    @diff_file << "         parser = BATCH_PARSERS[type]"
    @diff_file << "         if type == 'missing' || !parser"
    @diff_file << "           io.seek(size.to_i + 1, IO::SEEK_CUR)"

    assert_equal 1, @diff_file.hunks.count
    assert_equal 8, @diff_file.total_number_of_lines
    assert_equal 1, @diff_file.total_additions
    assert_equal 1, @diff_file.total_deletions
  end

end