begin
  CloudModel::Host
rescue
  require File.expand_path('../../app/models/cloud_model/host', CloudModel::Engine.called_from)
end

module CloudModel
  module Api
    module Hetzner
      module Host
        def self.included(base)
          base.extend ClassMethods
          base.field :hetzner_server_info, type: Hash
          base.around_save :set_hetzner_name
        end


        module ClassMethods
        end

        def set_hetzner_name
          begin
            if result = yield and name_changed?
              CloudModel::Api::Hetzner::Server.set_name primary_address.ip, name

            end
          rescue
          end

          result
        end
      end
    end
  end
end

ActiveSupport::Reloader.to_prepare do
  CloudModel::Host.class_eval { include CloudModel::Api::Hetzner::Host }
end