# Identify

Identify helps build complex classes  

## Installation

Add this line to your application's Gemfile:

    gem 'identify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install identify

## Usage

Provides methods for constructing and retrieving a domain object. Identify is indended to replace persisting data that is tightly couple to domain logic.

Many times you might see a database structure that will always remain static until the codebase changes.  This is a headache to seed the proper data for the objects to work.  Instead use identify to write these classes in code.

Likewise, many classes may be constructed that do the same thing... just a little bit differently. Like a use case.  Identify allows easy retreival of data.

### Basic Example

    class Activity 
      include Identify

      attr_reader :title

      def titled title
        @title = title
      end
    end

    Activity.identify :new_activity do
      titled "Created something new"
    end

    Activity.find_identifiable(:new_activity).title # => "Created something new"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
