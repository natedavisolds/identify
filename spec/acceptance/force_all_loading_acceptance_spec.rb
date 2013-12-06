require 'identify'

describe "Force all Loading" do

  class LazyLoadingTest
    include Identify

    attr_accessor :successful

    set_identify_root File.expand_path("../lazy_loading_tests/", __FILE__)

    def initialize
      @successful = false
    end

    def successful?
      @successful
    end
  end

  it "loads all the identifiable before calling all" do
    LazyLoadingTest.all_identifiables.length.should == 1
  end
end