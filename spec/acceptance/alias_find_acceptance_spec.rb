require 'spec_helper'

describe "Can find identifiables using the short hand find" do
  class AliasFindingTestCase
    include Identitee
  end

  it "uses the find alias" do
    test_case = AliasFindingTestCase.identify :test
    expect(AliasFindingTestCase.find(:test)).to eq test_case
  end

  class OtherFindTestCase
    def self.find echo
      "other find #{echo}"
    end

    include Identitee
  end
  
  it "uses the existing find method" do
    test_case = OtherFindTestCase.identify :test
    expect(OtherFindTestCase.find(:test)).to eq "other find test"
  end

  it "will pass a default value" do
    oftc = AliasFindingTestCase.find(:test_default, "default")
    expect(oftc).to eq "default"
  end

  it "will pass a block value" do
    oftc = AliasFindingTestCase.find(:test_default) do
      "default"
    end

    expect(oftc).to eq "default"
  end
end