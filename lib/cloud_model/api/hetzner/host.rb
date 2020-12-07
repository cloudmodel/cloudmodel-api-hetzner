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
          name_changed = name_changed?
          if result = yield and name_changed
            begin
              CloudModel::Api::Hetzner::Server.set_name primary_address.ip, name
            rescue
            end
          end

          result
        end
      end
    end
  end
end

CloudModel::Host.class_eval { include CloudModel::Api::Hetzner::Host }