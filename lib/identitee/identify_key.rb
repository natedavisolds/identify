module Identitee
  module IdentifyKey
    def key
      self.class.find_identifiable_key self
    end
  end
end
