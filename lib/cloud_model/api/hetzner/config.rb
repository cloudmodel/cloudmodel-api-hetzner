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

module CloudModel::Api::Hetzner::ConfigInclude
  def hetzner
    @hetzner ||= CloudModel::Api::Hetzner::Config.new
  end
end

CloudModel::ConfigModules::Api.class_eval { include CloudModel::Api::Hetzner::ConfigInclude }