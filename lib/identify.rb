require "identify/version"
require "identify/identitee"
require "identify/identitee/find_alias"

module Identify
  def self.included base
    base.extend ::Identify::Identitee
    base.extend ::Identify::Identitee::FindAlias unless method_defined? :find
  end
end
