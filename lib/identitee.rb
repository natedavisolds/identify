require "identitee/version"
require "identitee/identify"
require "identitee/identify/find_alias"

module Identitee
  def self.included base
    base.extend ::Identitee::Identify
    base.extend ::Identitee::Identify::FindAlias unless method_defined? :find
  end
end
