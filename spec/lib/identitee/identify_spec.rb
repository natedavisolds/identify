require 'spec_helper'

describe Identitee do
  it "acts as a constructor" do
    TestIdentifyInitialize = Class.new do
      include Identitee
    end

    TestIdentifyInitialize.identify(:test).should be_a TestIdentifyInitialize
  end

  it "registers the identifiable" do
    TestIdentifyRegister = Class.new do
      include Identitee
    end

    instance = TestIdentifyRegister.identify :test

    TestIdentifyRegister.find_identifiable(:test).should == instance
  end

  it "passes extra parameters through to new" do
    TestIdentifyMultipleParams = Class.new do
      include Identitee

      attr_reader :attrib

      def initialize attrib
        @attrib = attrib
      end
    end

    instance = TestIdentifyMultipleParams.identify :test, "Testing"
    instance.attrib.should == "Testing"
  end

  it "passes the block to the new as well" do
    TestIdentifyPassingBlock = Class.new do
      include Identitee

      attr_reader :attrib

      def set_attrib str
        @attrib = str
      end
    end

    instance = TestIdentifyPassingBlock.identify :test do
      set_attrib "It ran the block!"
    end

    instance.attrib.should == "It ran the block!"
  end

  it "simplifies find_identifiable to find" do
    TestAddingFind = Class.new

    TestAddingFind.should_not respond_to :find

    TestAddingFind.send(:include, Identitee)

    TestAddingFind.should respond_to :find
  end

  it "doesn't symplify find_identifiable when find exists" do
    TestNotReplacingFind = Class.new do
      def self.find key
        key
      end
    end

    TestNotReplacingFind.find("something").should == "something"

    TestNotReplacingFind.send(:include, Identitee)

    TestNotReplacingFind.find("something").should == "something"
    TestNotReplacingFind.find_identifiable("something", "Unknown").should == "Unknown"
  end

  it "finds the key for an identifiable" do
    TestFindIdentiteeKey = Class.new do
      include Identitee
    end

    instance = TestFindIdentiteeKey.identify :testing_key

    TestFindIdentiteeKey.find_identifiable_key(instance).should eq 'testing_key'
  end
end