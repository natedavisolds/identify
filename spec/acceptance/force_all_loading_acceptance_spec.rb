require 'spec_helper'

describe "Force all Loading" do
  class LoadingAllTest
    include Identitee
    set_identify_root File.expand_path("../loading_all_tests/", __FILE__)
  end

  it "loads all the identifiable before calling all" do
    identifiables = LoadingAllTest.all_identifiables
    identifiables.length.should == 2
  end
end