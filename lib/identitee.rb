require "identitee/version"
require "identitee/identify"
require "identitee/default_path_builder"
require "identitee/identify/find_alias"

module Identitee
  def self.included base
    base.extend ::Identitee::Identify
    base.extend ::Identitee::Identify::FindAlias unless base.method_defined? :find

    base.set_identitee_root Identitee::DefaultPathBuilder.to_path caller, base
  end
end
