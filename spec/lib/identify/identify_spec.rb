require 'identify'

describe Identify do
  it "exposes an identify method" do
    klass = Class.new do
      include Identify
    end

    klass.should respond_to :identify
  end

  it "exposes an identify method" do
    klass = Class.new do
      include Identify
    end

    klass.should respond_to :find_identifiable
  end
end