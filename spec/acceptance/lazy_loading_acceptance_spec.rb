require 'spec_helper'

describe "Lazy Loading" do

  class LazyLoadingTest
    include Identitee

    attr_accessor :successful

    add_identifiable_loader Identitee::Loader.new(identify_root_directory: File.expand_path("../loading_all_tests/", __FILE__)) 

    def initialize
      @successful = false
    end

    def successful?
      @successful
    end
  end

  it "lazy loads identifyables" do
    test = LazyLoadingTest.find_identifiable :autoload_test
    test.should_not be_nil
    test.should be_successful
  end
end