# GitDiff

A Ruby library for parsing the unified diff format generated with `git diff`

[![Code Climate](https://codeclimate.com/github/anolson/git_diff.png)](https://codeclimate.com/github/anolson/git_diff)
[![Build Status](https://travis-ci.org/anolson/git_diff.png?branch=master)](https://travis-ci.org/anolson/git_diff)

## Installation

Add this line to your application's Gemfile:

    gem 'git_diff'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_diff

## Usage

#### Generate a diff

```sh
$ git diff
diff --git a/README.md b/README.md
index bbbf9c9..9dff09f 100644
--- a/README.md
+++ b/README.md
@@ -25,7 +25,7 @@ Or install it yourself as:

     $ git diff

-#### Parse the output with
+#### Parse the output

     GitDiff.from_string(diff)

```

#### Parse the output

```ruby
require "git_diff"

diff = <<-DIFF
diff --git a/README.md b/README.md
index bbbf9c9..9dff09f 100644
--- a/README.md
+++ b/README.md
@@ -25,7 +25,7 @@ Or install it yourself as:

     $ git diff

-#### Parse the output with
+#### Parse the output

     GitDiff.from_string(diff)

DIFF

diff = GitDiff.from_string(diff)

puts " #{diff_file.number_of_additions} addition(s)."
puts " #{diff_file.number_of_deletions} deletion(s)."
```

_Outputs_
```
1 addition(s).
1 deletion(s).
```

## Run the tests

    $ bundle exec rake test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
