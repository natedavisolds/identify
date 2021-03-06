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

  it "lazy loads identifyables" do
    test = DefaultDirectorySetTest.find_identifiable :default_directory_test, nil
    expect(test).to_not be_nil
    expect(test).to be_successful
  end
end