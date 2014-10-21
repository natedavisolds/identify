require "identitee/version"
require "identitee/identify"
require "identitee/default_path_builder"
require "identitee/identify_key"
require "identitee/identify/find_alias"

module Identitee
  def self.included base
    base.extend ::Identitee::Identify
    base.extend ::Identitee::Identify::FindAlias unless base.method_defined? :find

    identify_root_directory = Identitee::DefaultPathBuilder.to_path caller, base
    base.add_identifiable_loader ::Identitee::Loader.new(identify_root_directory: identify_root_directory) 
  end
end
