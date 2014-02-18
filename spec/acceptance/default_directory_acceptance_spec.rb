require 'spec_helper'

describe "Default the directory to the caller classes directory and the pluralized version of the class name" do
  class DefaultDirectorySetTest
    include Identitee

    attr_accessor :successful

    def initialize
      @successful = false
    end

    def successful?
      @successful
    end
  end

  it "has a identify_root_directory" do
    DefaultDirectorySetTest.identify_root_directory.should =~ /default_directory_set_tests/
  end

  it "lazy loads identifyables" do
    test = DefaultDirectorySetTest.find_identifiable :default_directory_test
    test.should_not be_nil
    test.should be_successful
  end
end