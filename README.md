# Identitee [![Build Status](https://travis-ci.org/natedavisolds/identify.png?branch=master)](https://travis-ci.org/natedavisolds/identify) [![Code Climate](https://codeclimate.com/github/natedavisolds/identify.png)](https://codeclimate.com/github/natedavisolds/identify) [![Coverage Status](https://coveralls.io/repos/natedavisolds/identify/badge.png?branch=master)](https://coveralls.io/r/natedavisolds/identify?branch=master)

Provides methods for building and retrieving instances of a class. Identify is intended to replace persisting data that is tightly tied to domain logic.

Many times you might see a database structure that will always remain static until the codebase changes.  This is a headache to seed the proper data for the objects to work.  Instead use identify to write these classes in code.

Likewise, many classes may be constructed that do the same thing... just a little bit differently. Like a use case.  Identitee allows easy retrieval of data.

### Finding

Find an identifiable through the `find_identifiable` class method. (See the Basic Example)

    class Activity
      include Identitee

      attr_reader :title

      def titled title
        @title = title
      end
    end

    Activity.identify :new_activity do
      titled "Created something new"
    end

    Activity.find_identifiable(:new_activity).title # => "Created something new"

### Loading identifiables

Identitee will try to autoload the identifiables if it doesn't already know about them.  By default it will use the pluralize class_name of the identifiable from the folder that the source file is in.  The load path can explicitly be set with the `set_identify_root` method call.

    class LazyLoadingTest
      include Identitee

      attr_accessor :successful

      set_identitee_root File.expand_path("../lazy_loading_tests/", __FILE__)

      def initialize
        @successful = false
      end

      def successful?
        @successful
      end
    end

## Installation

Add this line to your application's Gemfile:

    gem 'identitee'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install identify

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
