require "test_helper"

class GitDiffTest < MiniTest::Unit::TestCase

  def setup
    string = <<-'DIFF'
diff --git a/lib/grit/commit.rb b/lib/grit/commit.rb
index 403ea33..dd4b590 100644
--- a/lib/grit/commit.rb
+++ b/lib/grit/commit.rb
@@ -27,6 +27,7 @@

       lines = info.split("\n")
       tree = lines.shift.split(' ', 2).last
+
       parents = []
       parents << lines.shift[7..-1] while lines.first[0, 6] == 'parent'
       author,    authored_date  = Grit::Commit.actor(lines.shift)
diff --git a/lib/grit/repo.rb b/lib/grit/repo.rb
index 033b446..0e2d140 100644
--- a/lib/grit/repo.rb
+++ b/lib/grit/repo.rb
@@ -180,7 +180,7 @@ module Grit
       io = StringIO.new(text)
       objects = []
       while line = io.gets
-        sha, type, size = line.split(" ", 3)
+        sha, type, size = line.split(" ", 3) #wut
         parser = BATCH_PARSERS[type]
         if type == 'missing' || !parser
           io.seek(size.to_i + 1, IO::SEEK_CUR)
    DIFF

    @diff = GitDiff::from_string(string)
  end

  def first_diff_file
    @diff.files.first
  end

  def last_diff_file
    @diff.files.last
  end

  def test_returns_the_number_of_files
    assert_equal 2, @diff.files.count
  end

  def test_returns_the_number_of_lines_per_file
    assert_equal 7, first_diff_file.stats.total_number_of_lines
    assert_equal 8, last_diff_file.stats.total_number_of_lines
  end

  def test_returns_the_path_info
    assert_equal "lib/grit/commit.rb", first_diff_file.a_path
    assert_equal "lib/grit/commit.rb", first_diff_file.b_path

    assert_equal "lib/grit/repo.rb", last_diff_file.a_path
    assert_equal "lib/grit/repo.rb", last_diff_file.b_path
  end

  def test_returns_the_blob_info
    assert_equal "403ea33", first_diff_file.a_blob
    assert_equal "dd4b590", first_diff_file.b_blob
    assert_equal "100644", first_diff_file.b_mode

    assert_equal "033b446", last_diff_file.a_blob
    assert_equal "0e2d140", last_diff_file.b_blob
    assert_equal "100644", last_diff_file.b_mode
  end

  def test_returns_the_total_number_of_additions
    assert_equal 1, first_diff_file.stats.total_number_of_additions
    assert_equal 1, last_diff_file.stats.total_number_of_additions
    assert_equal 2, @diff.stats.total_number_of_additions
  end

  def test_returns_the_total_number_of_subtractions
    assert_equal 0, first_diff_file.stats.total_number_of_deletions
    assert_equal 1, last_diff_file.stats.total_number_of_deletions
    assert_equal 2, @diff.stats.total_number_of_additions
  end

  def test_returns_the_hunk_range_info
    first_hunk = first_diff_file.hunks.first
    assert_equal "@@ -27,6 +27,7 @@", first_hunk.range_info.to_s

    second_hunk = last_diff_file.hunks.first
    assert_equal "@@ -180,7 +180,7 @@ module Grit", second_hunk.range_info.to_s
  end

  def test_returns_the_correct_line_numbers
    first_hunk = first_diff_file.hunks.first
    second_hunk = last_diff_file.hunks.first

    assert_equal [
      [27,27],
      [28,28],
      [29,29],
      [nil,30],
      [30,31],
      [31,32],
      [32,33]
      ], first_hunk.lines.map { |line| line.line_number.pair }

    assert_equal [
      [180,180],
      [181,181],
      [182,182],
      [183,nil],
      [nil,183],
      [184,184],
      [185,185],
      [186,186]
      ], second_hunk.lines.map { |line| line.line_number.pair }
  end
end
