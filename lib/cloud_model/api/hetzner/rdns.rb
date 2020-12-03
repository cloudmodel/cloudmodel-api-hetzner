module CloudModel
  module Api
    module Hetzner
      class Rdns
        def self.all
          CloudModel::Api::Hetzner.request_get 'rdns'
        end

        def self.set_ptr ip, ptr
          unless ptr.blank?
            CloudModel::Api::Hetzner.request_post "rdns/#{ip}", ptr: ptr
          else
            CloudModel::Api::Hetzner.request_delete "rdns/#{ip}"
          end
        end
      end
    end
  end
end