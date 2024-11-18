begin
  CloudModel::AddressResolution
rescue
  require File.expand_path('../../app/models/cloud_model/address_resolution', CloudModel::Engine.called_from)
end

module CloudModel
  module Api
    module Hetzner
      module AddressResolution
        def self.included(base)
          base.extend ClassMethods
          base.around_save :set_hetzner_rdns
          base.around_destroy :remove_hetzner_rdns
        end


        module ClassMethods
        end

        def set_hetzner_rdns
          name_changed = name_changed?
          if result = yield and name_changed
            begin
              CloudModel::Api::Hetzner::Rdns.set_ptr ip, name
            rescue
            end
          end

          result
        end

        def remove_hetzner_rdns
          if result = yield
            CloudModel::Api::Hetzner::Rdns.set_ptr ip, nil
          end

          result
        end
      end
    end
  end
end

