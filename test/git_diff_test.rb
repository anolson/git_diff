require "test_helper"

class GitDiffTest < Minitest::Test

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
diff --git a/lib/grit/new_file.rb b/lib/grit/new_file.rb
new file mode 100644
index 0000000..24f83d1
--- /dev/null
+++ b/lib/grit/new_file.rb
@@ -0,0 +1 @@
+#
diff --git a/grit/old_file.rb b/grit/old_file.rb
deleted file mode 100644
index ba6b733..0000000
--- a/lib/grit/old_file.rb
+++ /dev/null
@@ -1 +0,0 @@
-#
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
    assert_equal 4, @diff.files.count
  end

  def test_returns_the_number_of_lines_per_file
    assert_equal 7, first_diff_file.stats.number_of_lines
    assert_equal 8, last_diff_file.stats.number_of_lines
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
    assert_equal 1, first_diff_file.stats.number_of_additions
    assert_equal 1, last_diff_file.stats.number_of_additions
    assert_equal 3, @diff.stats.number_of_additions
  end

  def test_returns_the_total_number_of_subtractions
    assert_equal 0, first_diff_file.stats.number_of_deletions
    assert_equal 1, last_diff_file.stats.number_of_deletions
    assert_equal 2, @diff.stats.number_of_deletions
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

  def test_binary_file_diff
    diff = GitDiff.from_string 'diff --git a/app/assets/bin.eot b/app/assets/bin.eot
new file mode 100644
index 0000000..2cbab9c
Binary files /dev/null and b/app/assets/bin.eot differ'

    refute_nil diff
    assert_instance_of GitDiff::Diff, diff

    assert_equal 1, diff.files.count
    file = diff.files[0]

    assert file.binary
    assert_equal '/dev/null', file.a_path
    assert_equal "app/assets/bin.eot", file.b_path
  end

  def test_perm_change_diff
    diff = GitDiff.from_string 'diff --git a/bin/setup b/bin/setup
old mode 100644
new mode 100755'

    refute_nil diff
    assert_instance_of GitDiff::Diff, diff

    assert_equal 1, diff.files.count
    file = diff.files[0]

    assert_equal 0, file.hunks.count

    assert_equal "bin/setup", file.a_path
    assert_equal "bin/setup", file.b_path
  end

  def test_rename_diff
    diff = GitDiff.from_string 'diff --git a/lib/path1/my_file.rb b/lib/path2/my_file2.rb
similarity index 100%
rename from lib/path1/my_file.rb
rename to lib/path2/my_file2.rb'

    refute_nil diff
    assert_instance_of GitDiff::Diff, diff

    assert_equal 1, diff.files.count
    file = diff.files[0]

    assert_equal 0, file.hunks.count

    assert_equal "lib/path1/my_file.rb", file.a_path
    assert_equal "lib/path2/my_file2.rb", file.b_path
  end
end
