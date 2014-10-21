require 'spec_helper'

describe "Force all Loading" do
  class LoadingAllTest
    include Identitee
    add_identifiable_loader Identitee::Loader.new(identify_root_directory: File.expand_path("../loading_all_tests/", __FILE__)) 
  end

  it "loads all the identifiable before calling all" do
    identifiables = LoadingAllTest.find_all_identifiables
    identifiables.length.should == 2
  end
end