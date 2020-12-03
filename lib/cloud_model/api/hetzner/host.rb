begin
  CloudModel::Host
rescue
  require File.expand_path('../../app/models/cloud_model/host', CloudModel::Engine.called_from)
end

CloudModel::Host.class_eval do
  field :hetzner_server_info, type: Hash

  around_save :set_hetzner_name

  def set_hetzner_name
    name_changed = name_changed?
    if result = yield and name_changed
      CloudModel::Api::Hetzner::Server.set_name primary_address.ip, name
    end

    result
  end
end