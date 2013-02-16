module Identify
  class Loader
    def initialize options={}
      @identify_root_directory = options.delete(:identify_root_directory)
    end

    def lazy_load filename
      full_path = [identify_root_directory, "#{filename}.rb"].compact.join('/')

      if File.exists? full_path
        force_load full_path
      else
        yield if block_given?
      end
    end

    def force_load filename
      load filename.to_s
    end

    attr_reader :identify_root_directory
  end
end