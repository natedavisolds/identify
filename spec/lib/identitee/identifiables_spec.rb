require 'spec_helper'

module Identitee
  describe Identifiables do
    let(:instance) { stub }
    let(:identifiables) { Identifiables.new }

    context "when found by key" do
      it "returns the instance" do
        identifiables.register :foo, stub
        identifiables.register :test_id, instance

        identifiables.find(:test_id).should == instance
      end
    end

    context "when not found by key" do
      it "returns value returned by a given block" do
        identifiable = identifiables.find(:foo) do |id|
          "#{id} not found"
        end

        identifiable.should == "foo not found"
      end

      it "returns the second value if no block given" do
        identifiable = identifiables.find :foo, "Default value"

        identifiable.should == "Default value"
      end

      it "returns the second value if no block given even when that value is nil" do
        identifiable = identifiables.find :foo, nil

        identifiable.should be_nil
      end

      it "raises IdentifiableNotFound if no block or default value" do
        expect { identifiables.find(:foo) }
          .to raise_error Identitee::IdentifiableNotFound
      end
    end

    context "when requesting all the identifiables" do
      it "gives an array of all the known instances" do
        identifiables.register :foo, instance
        identifiables.all.should == [instance]
      end
    end

    context "when find the key" do
      it "gives the string identifier for the instance" do
        identifiables.register :foo, instance
        identifiables.find_key(instance).should eq 'foo'
      end
    end
  end
end