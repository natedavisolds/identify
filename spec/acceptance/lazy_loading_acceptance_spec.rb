require 'identitee'

describe "Lazy Loading" do

  class LazyLoadingTest
    include Identitee

    attr_accessor :successful

    set_identify_root File.expand_path("../lazy_loading_tests/", __FILE__)

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