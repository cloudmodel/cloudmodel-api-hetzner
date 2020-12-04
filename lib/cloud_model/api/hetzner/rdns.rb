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

        def self.sync_to_address_resolutions
          all.each do |info|
            ip = info['rdns']['ip']

            resolution = CloudModel::AddressResolution.find_or_initialize_by('ip' => ip)
            resolution.name = info['rdns']['ptr']
            resolution.save
          end
        end
      end
    end
  end
end