module Identitee
  describe IdentifyKey do

    class IdentifyKeyExample
      include Identitee
      include IdentifyKey

      add_identifiable_loader Identitee::Loader.new(identify_root_directory: File.expand_path("../loading_all_tests/", __FILE__)) 
    end

    it "has the key method" do
      expect(IdentifyKeyExample.new).to respond_to :key
    end

    it "returns the correct key" do
      example = IdentifyKeyExample.identify :example_key_test
      expect(example.key).to eq "example_key_test"
    end
  end
end