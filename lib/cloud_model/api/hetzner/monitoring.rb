# begin
#   CloudModel::Monitoring
# rescue
#   require File.expand_path('../../app/models/cloud_model/monitoring', CloudModel::Engine.called_from)
# end
#
# begin
#   CloudModel::Monitoring::BaseChecks
# rescue
#   require File.expand_path('../../app/models/cloud_model/monitoring/base_checks', CloudModel::Engine.called_from)
# end
require "cloud_model/monitoring"

module CloudModel
  module Api
    module Hetzner
      class Monitoring < CloudModel::Monitoring::BaseChecks
        def self.check
          handle_cloudmodel_monitoring_exception :hetzner, '_Hetzner_', 2 do
            # Without configured credentials there is nothing to check — don't
            # even try (the request would just 401 and record a crash issue,
            # e.g. in development environments). Counts as success inside the
            # handler, so a stale check_crashed issue resolves itself.
            if CloudModel.config.api.hetzner.user.blank?
              puts "[_Hetzner_] * Skipping server check (no API credentials configured)"
            else
              puts "[_Hetzner_] * Check for servers"
              CloudModel::Api::Hetzner::Server.sync_to_hosts
              puts "[_Hetzner_]     -> \e[32mOK\e[39m"
            end
          end
        end
      end
    end
  end
end

CloudModel::Monitoring.register_check CloudModel::Api::Hetzner::Monitoring