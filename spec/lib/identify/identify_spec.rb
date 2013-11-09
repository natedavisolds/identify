require 'identify'

describe Identify do
  it "acts as a constructor" do
    TestIdentifyInitialize = Class.new do
      include Identify
    end

    TestIdentifyInitialize.identify(:test).should be_a TestIdentifyInitialize
  end

  it "registers the identifiable" do
    TestIdentifyRegister = Class.new do
      include Identify
    end

    instance = TestIdentifyRegister.identify :test

    TestIdentifyRegister.find_identifiable(:test).should == instance
  end

  it "passes extra parameters through to new" do
    TestIdentifyMultipleParams = Class.new do
      include Identify

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
      include Identify

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

    TestAddingFind.send(:include, Identify)

    TestAddingFind.should respond_to :find
  end

  it "doesn't symplifies find_identifiable when find exists" do
    TestNotReplacingFind = Class.new do
      def self.find key
        key
      end
    end

    TestNotReplacingFind.find("something").should == "something"

    TestNotReplacingFind.send(:include, Identify)

    TestNotReplacingFind.find("something").should == "something"
    TestNotReplacingFind.find_identifiable("something").should == "Unknown"
  end
end