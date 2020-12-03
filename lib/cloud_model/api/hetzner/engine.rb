module CloudModel
  module Api
    module Hetzner
      class Engine < ::Rails::Engine
        isolate_namespace CloudModel::Api::Hetzner
      end
    end
  end
end
