module CloudModel
  module Api
    module Hetzner
      class Server
        def self.all
          CloudModel::Api::Hetzner.request_get 'server'
        end

        def self.set_name ip, name
          CloudModel::Api::Hetzner.request_post "server/#{ip}", server_name: name
        end

        def self.sync_to_hosts
          all.each do |info|
            ip = info['server']['server_ip']

            host = CloudModel::Host.where('primary_address.ip' => ip).first

            unless host
              ip_info = CloudModel::Api::Hetzner.request_get "ip/#{ip}"

              CloudModel::Host.all.map(&:private_network).map(&:cidr).sort{|a,b| a.cmp b}.last.next.to_s

              host_document = {
                name: info['server']['server_name'],
                primary_address: {
                  ip: ip,
                  subnet: ip_info['ip']['mask'],
                  gateway: ip_info['ip']['gateway']
                }
              }

              private_network = CloudModel::Host.all.map(&:private_network).map(&:cidr).sort{|a,b| a.cmp b}.last.next
              host_document[:private_network] = {
                ip: private_network.network.to_s,
                subnet: 25,#private_network.netmask.to_s.gsub('/', '').to_i,
                gateway: private_network.nth(1).to_s
              }

              host = CloudModel::Host.new(host_document)
            end

            info['server']['subnet'].each do |subnet|
              unless host.addresses.where(ip: subnet['ip']).size > 0
                subnet_info = CloudModel::Api::Hetzner.request_get "subnet/#{subnet['ip']}"

                host.addresses.new(
                  ip: subnet['ip'],
                  subnet: subnet['mask'],
                  gateway: subnet_info['subnet']['gateway']
                )
              end
            end

            host.hetzner_server_info = info['server']
            host.save
          end
        end
      end
    end
  end
end