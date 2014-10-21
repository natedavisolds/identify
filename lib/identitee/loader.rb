module Identitee
  class Loader
    def initialize options={}
      @identify_root_directory = options.delete(:identify_root_directory)
    end

    def loadable? filename
      File.exists? full_path(filename)
    end

    def lazy_load filename
      if loadable? filename
        force_load full_path(filename)
      else
        yield if block_given?
      end
    end

    def load_all
      if not_fully_loaded?
        force_full_load
      end
    end

    private

    attr_reader :identify_root_directory

    def full_path filename
      [identify_root_directory, "#{filename}.rb"].compact.join('/')
    end

    def force_full_load
      @fully_loaded = true

      Dir.glob("#{identify_root_directory}/*.rb").each do |file_name|
        lazy_load File.basename(file_name, ".*")
      end
    end

    def force_load filename
      load filename.to_s
    end

    def loaded_already?
      @fully_loaded == true
    end

    def not_fully_loaded?
      not loaded_already?
    end
  end
end