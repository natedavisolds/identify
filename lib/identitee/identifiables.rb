require 'identitee/identifiable_not_found'

module Identitee
  class Identifiables
    def initialize 
      @instances = {}
    end

    def register key, instance
      instances[key.to_s] = instance
    end

    def find key, *default_values, &block
      instances.fetch key.to_s do 
        if block
          block.call key
        elsif default_values.length > 0
          default_values.first
        else
          raise ::Identitee::IdentifiableNotFound
        end
      end
    end

    def find_key instance
      instances.invert.fetch(instance, nil)
    end

    def all
      instances.values
    end

    private 

    attr_reader :instances
  end
end