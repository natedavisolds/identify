require 'spec_helper'

module Identitee
  describe Loader do
    context "when source file does not exist" do
      it "fails gracefully by calling block" do
        loader = Loader.new

        loader.lazy_load('unknown') do
          "Passing"
        end.should == "Passing"
      end
    end

    context "when source file does exist" do
      it "loads the file" do
        loader = Loader.new

        File.stub!(:exists?).with('known.rb').and_return(true)

        loader.should_receive(:force_load).with('known.rb').once

        loader.lazy_load('known')
      end
    end
  end
end