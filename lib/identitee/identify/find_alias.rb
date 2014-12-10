module Identitee 
  module Identify
    module FindAlias
      def find candidate_id, default=nil, &block
        if default.nil?
          find_identifiable candidate_id, &block
        else
          find_identifiable candidate_id, default, &block
        end
      end
    end
  end
end