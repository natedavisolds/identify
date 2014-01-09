require 'spec_helper'

describe "Can find identifiables using the short hand find" do
  class AliasFindingTestCase
    include Identitee
  end

  it "uses the find alias" do
    test_case = AliasFindingTestCase.identify :test
    AliasFindingTestCase.find(:test).should eq test_case
  end

  class OtherFindTestCase
    def self.find echo
      "other find #{echo}"
    end

    include Identitee
  end
  
  it "uses the existing find method" do
    test_case = OtherFindTestCase.identify :test
    OtherFindTestCase.find(:test).should == "other find test"
  end
end