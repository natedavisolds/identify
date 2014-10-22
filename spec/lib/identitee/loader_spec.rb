require 'spec_helper'

module Identitee
  describe Loader do
    context "when source file does not exist" do
      it "fails gracefully by calling block" do
        result = Loader.new.lazy_load('unknown') do
          "Passing"
        end

        expect(result).to eq "Passing"
      end
    end

    context "when source file does exist" do
      it "loads the file" do
        loader = Loader.new

        expect(File).to receive(:exists?).with('known.rb').and_return(true)

        expect(loader).to receive(:force_load).with('known.rb').once

        loader.lazy_load('known')
      end
    end
  end
end