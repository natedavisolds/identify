# Identitee [![Gem Version](https://badge.fury.io/rb/identitee.png)](http://badge.fury.io/rb/identitee) [![Build Status](https://travis-ci.org/natedavisolds/identify.png?branch=master)](https://travis-ci.org/natedavisolds/identify) [![Code Climate](https://codeclimate.com/github/natedavisolds/identify.png)](https://codeclimate.com/github/natedavisolds/identify) [![Coverage Status](https://coveralls.io/repos/natedavisolds/identify/badge.png?branch=master)](https://coveralls.io/r/natedavisolds/identify?branch=master)

Provides methods for building and retrieving instances of a class. Identify is intended to replace persisting data that is tightly tied to domain logic.

Many times you might see a database structure that will always remain static until the codebase changes.  This is a headache to seed the proper data for the objects to work.  Instead use identify to write these classes in code.

Likewise, Identitee extends composition by building objects which behave the same but with different values.

### Finding

Find an identifiable through the `find_identifiable` (aliased also to find) class method. (See the Basic Example)

```ruby
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
    Activity.find(:new_activity).title # => "Created something new"
```
    
### When not found

You can set a default in two ways.  First, pass the default as the second parameter to find

```ruby
    Activity.find("some_unknown_key", NullActivity.new)
```

If the key is not found, it will use the value passed as the second parameter.

Even more useful way to set a default value is through as block:

```ruby
    Activity.find("some_unknown_key") do |key|
      Activity.identify(key)
    end
```
    
When the key isn't found the block is run with the key passed to it.  Here we are dynamically creating activities when they are not yet defined.  This is great when we want the full power of the instance methods but we are okay with the default configuration (Think NullObject strategy).
    
### A Self aware instance

It is handy to have the key we used to identify.  To give your instance objects access to key, include Identitee::IdentifyKey.

```ruby
    class IdentifyKeyExample
      include Identitee
      include IdentifyKey
    end
```
Access it by calling the #key method.
```ruby
    example = IdentifyKeyExample.identify 'test_key'
    example.key
    # => 'text_key'
```
### Loading identifiables

Identitee will try to autoload the identifiables if it doesn't already know about them.  By default it will use the pluralize class_name of the identifiable from the folder that the source file is in.  Other loaders can be added to expose additional paths.
```ruby
    class LazyLoadingTest
      include Identitee

      attr_accessor :successful

      add_loader MyLoader.new

      def initialize
        @successful = false
      end

      def successful?
        @successful
      end
    end
```

## Installation

Add this line to your application's Gemfile:

    gem 'identitee'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install identitee

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
