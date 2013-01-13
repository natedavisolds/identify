require 'identify/identifiables'

module Identify
  describe Identifiables do
    it "can be instantiated" do
      Identifiables.new.should be_a Identifiables
    end
  end
end