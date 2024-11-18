require "cloudmodel"
#require "cloud_model/engine"

if Rails.env.test?
  require "cloud_model/api/hetzner/engine"
end
require "cloud_model/api/hetzner/config"
require "cloud_model/api/hetzner/address_resolution"
require "cloud_model/api/hetzner/host"
require "cloud_model/api/hetzner/monitoring"
require "cloud_model/api/hetzner/rdns"
require "cloud_model/api/hetzner/server"

module CloudModel
  module Api
    module Hetzner
      def self.send_request request
        uri = URI.parse("https://robot-ws.your-server.de/")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request.basic_auth CloudModel.config.api.hetzner.user, CloudModel.config.api.hetzner.password

        response = http.request request

        if response.kind_of? Net::HTTPSuccess
          begin
            JSON.parse response.body
          rescue
            response.body
          end
        else
          puts "error #{response.code}: #{response.body}"
          false
        end
      end

      def self.request_get action
        uri = URI("https://robot-ws.your-server.de/#{action}")
        send_request(Net::HTTP::Get.new uri)
      end

      def self.request_delete action
        uri = URI("https://robot-ws.your-server.de/#{action}")
        send_request Net::HTTP::Delete.new uri
      end

      def self.request_post action, data
        uri = URI("https://robot-ws.your-server.de/#{action}")
        request = Net::HTTP::Post.new uri
        request.set_form_data data
        send_request request
      end
    end
  end
end

# ActiveSupport::Reloader.to_prepare do
#   CloudModel::AddressResolution.class_eval { include CloudModel::Api::Hetzner::AddressResolution }
#   CloudModel::Host.class_eval { include CloudModel::Api::Hetzner::Host }
# end