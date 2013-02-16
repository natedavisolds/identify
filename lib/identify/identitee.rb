require "identify/identifiables"
require "identify/loader"

module Identify
  module Identitee
    def identify id, *extra_parameters, &block
      instance = new *extra_parameters
      instance.instance_eval &block if block_given?

      identifiables.register id, instance
      instance
    end

    def find_identifiable candidate_id
      identifiables.find candidate_id.to_s do
        Identify::Loader.new(identify_root_directory: identify_root_directory).lazy_load(candidate_id.to_s)
        identifiables.find candidate_id, "Unknown"
      end
    end

    def set_identify_root path_to_template_root
      @identify_root_directory = path_to_template_root
    end

    def identify_root_directory
      @identify_root_directory
    end

    def identifiables
      @identifiables ||= Identifiables.new
    end

    module FindAlias
      def find candidate_id
        find_identifiable candidate_id
      end
    end
  end
end
