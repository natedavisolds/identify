require "identitee/identifiables"
require "identitee/loader"

module Identitee
  module Identify
    def identify id, *extra_parameters, &block
      instance = new *extra_parameters
      instance.instance_eval &block if block_given?

      identifiables.register id, instance
      instance
    end

    def find_identifiable key, default=new, &block
      identifiables.find key, default, &block
    end

    def find_identifiable_key instance
      identifiables.find_key instance
    end

    def find_all_identifiables
      identifiables.all
    end

    def add_identifiable_loader loader
      identifiables.add_loader loader
    end

    def identifiables
      @identifiables ||= Identifiables.new
    end
  end
end
