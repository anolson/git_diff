# GitDiff

A Ruby library for parsing diffs generated with `git diff`

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

    $ git diff

#### Parse the output with

    GitDiff.from_string(diff)

## Run the tests

    $ bundle exec rake test

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
