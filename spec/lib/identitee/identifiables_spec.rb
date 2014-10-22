require 'spec_helper'

module Identitee
  describe Identifiables do
    let(:instance) { double }
    let(:identifiables) { Identifiables.new }

    context "when found by key" do
      it "returns the instance" do
        identifiables.register :foo, double
        identifiables.register :test_id, instance

        expect(identifiables.find(:test_id)).to eq instance
      end
    end

    context "when not found by key" do
      it "returns value returned by a given block" do
        identifiable = identifiables.find(:foo) do |id|
          "#{id} not found"
        end

        expect(identifiable).to eq "foo not found"
      end

      it "returns the second value if no block given" do
        identifiable = identifiables.find :foo, "Default value"

        expect(identifiable).to eq "Default value"
      end

      it "returns the second value if no block given even when that value is nil" do
        identifiable = identifiables.find :foo, nil

        expect(identifiable).to be_nil
      end

      it "raises IdentifiableNotFound if no block or default value" do
        expect { identifiables.find(:foo) }
          .to raise_error Identitee::IdentifiableNotFound
      end
    end

    context "when requesting all the identifiables" do
      it "gives an array of all the known instances" do
        identifiables.register :foo, instance
        expect(identifiables.all).to include instance
      end
    end

    context "when find the key" do
      it "gives the string identifier for the instance" do
        identifiables.register :foo, instance
        expect(identifiables.find_key(instance)).to eq 'foo'
      end
    end
  end
end