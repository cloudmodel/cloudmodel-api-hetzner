module CloudModel
  module Api
    module Hetzner
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
