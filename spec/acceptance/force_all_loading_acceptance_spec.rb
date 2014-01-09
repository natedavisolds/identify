require 'spec_helper'

describe "Force all Loading" do

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

  it "loads all the identifiable before calling all" do
    autoload_instance = LazyLoadingTest.all_identifiables.first
    autoload_instance.should be_successful
  end
end