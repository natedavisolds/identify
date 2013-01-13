require 'identify/identifiables'

module Identify
  module Identitee
    def identify id, *extra_parameters, &block
      @identifiables ||= Identifiables.new

      instance = new *extra_parameters
      instance.instance_eval &block if block_given?
      @identifiables.register id, instance
      instance
    end

    def find_identifiable candidate_id
      @identifiables ||= Identifiables.new

      @identifiables.find candidate_id
    end
  end
end
