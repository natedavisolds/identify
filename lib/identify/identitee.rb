require 'identify/identifiables'

module Identify
  module Identitee
    def identify id, *extra_parameters, &block
      instance = new *extra_parameters
      instance.instance_eval &block if block_given?

      identifiables.register id, instance
      instance
    end

    def find_identifiable candidate_id
      identifiables.find candidate_id do
        Identify::Loader.new(path).load(candidate_id)
      end
    end

    def identifiables
      @identifiables ||= Identifiables.new
    end
  end
end
