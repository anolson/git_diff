require "test_helper"

class DiffFileTest < MiniTest::Unit::TestCase

  def setup
    @file = GitDiff::File.new
  end

  def test_from_string_with_a_diff
    file = GitDiff::File.from_string "diff --git"

    refute_nil file
    assert_instance_of GitDiff::File, file
  end

  def test_from_string_without_a_diff
    file = GitDiff::File.from_string ""

    assert_nil file
  end

  def test_blob_data_is_correctly_extracted
    @file << "index 033b446..0e2d140 100644"

    assert_equal "033b446", @file.a_blob
    assert_equal "0e2d140", @file.b_blob
  end

  def test_mode_data_is_correctly_extracted
    @file << "index 033b446..0e2d140 100644"

    assert_equal "100644", @file.b_mode
  end

  def test_paths_are_correctly_extracted
    @file << "--- a/lib/grit/repo.rb"
    @file << "+++ b/lib/grit/repo.rb"

    assert_equal "lib/grit/repo.rb", @file.a_path
    assert_equal "lib/grit/repo.rb", @file.b_path
  end

  def test_appending_a_hunk
    @file << "@@ -180,7 +180,7 @@ module Grit"
    @file << "       io = StringIO.new(text)"
    @file << "       objects = []"
    @file << "       while line = io.gets"
    @file << "-        sha, type, size = line.split(" ", 3)"
    @file << "+        sha, type, size = line.split(" ", 3) #wut"
    @file << "         parser = BATCH_PARSERS[type]"
    @file << "         if type == 'missing' || !parser"
    @file << "           io.seek(size.to_i + 1, IO::SEEK_CUR)"

    assert_equal 1, @file.hunks.count
    assert_equal 8, @file.stats.total_number_of_lines
    assert_equal 1, @file.stats.total_number_of_additions
    assert_equal 1, @file.stats.total_number_of_deletions
  end

end