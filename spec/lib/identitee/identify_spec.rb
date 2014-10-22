require 'spec_helper'

describe Identitee do
  it "acts as a constructor" do
    TestIdentifyInitialize = Class.new do
      include Identitee
    end

    expect(TestIdentifyInitialize.identify(:test)).to be_a TestIdentifyInitialize
  end

  it "registers the identifiable" do
    TestIdentifyRegister = Class.new do
      include Identitee
    end

    instance = TestIdentifyRegister.identify :test

    expect(TestIdentifyRegister.find_identifiable(:test)).to eq instance
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
    expect(instance.attrib).to eq "Testing"
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

    expect(instance.attrib).to eq "It ran the block!"
  end

  it "simplifies find_identifiable to find" do
    TestAddingFind = Class.new

    expect(TestAddingFind).to_not respond_to :find

    TestAddingFind.send(:include, Identitee)

    expect(TestAddingFind).to respond_to :find
  end

  it "doesn't symplify find_identifiable when find exists" do
    TestNotReplacingFind = Class.new do
      def self.find key
        key
      end
    end

    expect(TestNotReplacingFind.find("something")).to eq "something"

    TestNotReplacingFind.send(:include, Identitee)

    expect(TestNotReplacingFind.find("something")).to eq "something"
    expect(TestNotReplacingFind.find_identifiable("something", "Unknown")).to eq "Unknown"
  end

  it "finds the key for an identifiable" do
    TestFindIdentiteeKey = Class.new do
      include Identitee
    end

    instance = TestFindIdentiteeKey.identify :testing_key

    expect(TestFindIdentiteeKey.find_identifiable_key(instance)).to eq 'testing_key'
  end
end