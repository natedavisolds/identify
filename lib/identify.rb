require "identify/version"
require "identify/identitee"

module Identify
  def self.included base
    base.extend Identitee
    base.extend Identitee::FindAlias unless method_defined? :find
  end
end
