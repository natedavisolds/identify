require 'identify/identifiables'

module Identify
  describe Identifiables do
    let(:instance) { stub }
    let(:identifiables) { Identifiables.new }

    it "registers an instance" do
      identifiables.register :test_id, instance
      identifiables.should include instance
    end

    context "when found by key" do
      it "returns the instance" do
        identifiables.register :foo, stub
        identifiables.register :test_id, instance

        identifiables.find(:test_id).should == instance
      end
    end

    context "when not found by key" do
      it "returns value returned by a given block" do
        identifiable = identifiables.find(:foo) do
          "Not found"
        end

        identifiable.should == "Not found"
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
          .to raise_error Identify::IdentifiableNotFound
      end
    end
  end
end