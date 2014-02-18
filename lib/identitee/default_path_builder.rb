module Identitee
  class DefaultPathBuilder
    def self.to_path call_stack, including_class
      new(call_stack, including_class).to_path
    end

    def initialize call_stack, including_class
      @call_stack = call_stack
      @including_class = including_class
    end

    def to_path 
      [directory_of_caller, pluralized_class_name].join('/')
    end

    private

    attr_accessor :call_stack, :including_class

    def directory_of_caller 
      File.dirname most_recent_caller_path_without_line_number
    end

    def most_recent_caller_path_without_line_number
      most_recent_caller_path.split(':').first
    end

    def most_recent_caller_path
      call_stack.first.to_s
    end

    def pluralized_class_name
      including_class_name.gsub(/([A-Z]+)([A-Z])/,'\1_\2').
        gsub(/([a-z])([A-Z])/,'\1_\2').
        gsub('/' ,'__').
        gsub('::','__').
        downcase + "s"
    end

    def including_class_name
      including_class.name.to_s
    end
  end
end