Rails.application.routes.draw do
  mount CloudModel::Api::Hetzner::Engine => "/cloud_model-api-hetzner"
end
