require "identify/version"
require "identify/identitee"

module Identify
  def self.included base
    base.extend Identitee
  end
end
