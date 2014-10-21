require 'identitee/identifiable_not_found'
require 'identitee/empty_loader'

module Identitee
  class Identifiables
    def initialize 
      @instances = {}
      @loaders = []
      @all_loaded = false
    end

    def add_loader loader
      loaders << loader
    end

    def register key, instance
      instances[key.to_s] = instance
    end

    def find key, *default_values, &block
      instances.fetch key.to_s do 
        lazy_load key

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
    end

    def find_key instance
      instances.invert.fetch(instance, nil)
    end

    def all
      load_all unless all_loaded
      instances.values
    end

    def lazy_load key
      (loaders.detect { |loader| loader.loadable? key } || EmptyLoader.new).lazy_load key
    end

    private 

    def load_all  
      loaders.each { |loader| loader.load_all }
    end

    attr_reader :instances, :loaders, :all_loaded
  end
end