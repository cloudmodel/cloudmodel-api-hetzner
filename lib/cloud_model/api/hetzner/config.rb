require "cloud_model/config_modules/api"

module CloudModel
  module Api
    module Hetzner
      class Config
        attr_accessor :user, :password
      end
    end
  end
end

CloudModel::ConfigModules::Api.class_eval do
  def hetzner
    @hetzner ||= CloudModel::Api::Hetzner::Config.new
  end
end

