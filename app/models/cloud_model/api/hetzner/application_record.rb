module CloudModel
  module Api
    module Hetzner
      class ApplicationRecord < ActiveRecord::Base
        self.abstract_class = true
      end
    end
  end
end
