require 'spec_helper'

describe "Default the directory to the caller classes directory and the pluralized version of the class name" do
  class LoadingAllTest
    include Identitee
  end

  it "loads all the identifiable before calling all" do
    identifiables = LoadingAllTest.all_identifiables
    identifiables.length.should == 2
  end

  class LazyLoadingTest
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
    LazyLoadingTest.identify_root_directory.should =~ /lazy_loading_tests/
  end

  it "lazy loads identifyables" do
    test = LazyLoadingTest.find_identifiable :autoload_test
    test.should_not be_nil
    test.should be_successful
  end
end