require 'identify/loader'

module Identify
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

        identity = loader.lazy_load('known') do
          "Failing"
        end

        identity.should_not == "Failing"
      end
    end
  end
end