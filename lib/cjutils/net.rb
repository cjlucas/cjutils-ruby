require 'net/http'
require 'json'
require 'timeout'

module CJUtils
  module Net

    def self.external_ip
      body = ::Net::HTTP.get(URI('http://jsonip.com'))
      json = JSON.load(body) || {}
      json['ip']
    end
    
    def self.connectable?(host, port, proto = 'tcp', timeout = 5)
      port = port.to_i
    
      begin 
        Timeout.timeout(timeout) do
          case proto.downcase
          when 'tcp'
            s = TCPSocket.new(host, port) rescue nil
            s.close unless s.nil?
            s.nil? ? false : true
          end
        end
      rescue Timeout::Error
        false
      end
    end

    def self.connectable_externally?(port, proto = 'tcp', timeout = 5)
      connectable?(external_ip, port, proto, timeout)
    end

    def self.connectable_locally?(port, proto = 'tcp', timeout = 5)
      connectable?('127.0.0.1', port, proto, timeout)
    end
  end
end
