require 'spec_helper'

describe "Loader Integration Test" do
  it "loads a file" do
    identify_root_directory = File.expand_path('../test_files/', __FILE__)
    Identitee::Loader.new(identify_root_directory: identify_root_directory).lazy_load('test_lazy_load')
    expect(Identitee::Loader).to respond_to :just_created_method
  end
end