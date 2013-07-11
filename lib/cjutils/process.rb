require 'timeout'

module CJUtils
  class Process
    def self.kill(pid, signal = 'TERM', timeout = 0)
      ::Process.kill(signal, pid) rescue nil

      begin
        Timeout.timeout(timeout) do
          loop do
            break unless exists?(pid)
            puts 'waiting' if $DEBUG
            sleep(1)
          end
        end
      rescue Timeout::Error
        warn "PID #{pid} may still be running"
      end
    end

    def self.exists?(pid)
      return false if pid.nil?

      begin
        ::Process.kill(0, pid)
        true
      rescue Errno::ESRCH # process cant be found
        false
      rescue Errno::EPERM # operation not permitted, but still exists
        true
      end
    end

    def self.kill_for_pid_file(pid_file, signal = 'TERM', timeout = 0)
      pid = pid_for_pid_file(pid_file)
      unless pid.nil?
        kill(pid, signal, timeout) if exists?(pid)
      end
    end

    def self.pid_for_pid_file(pid_file)
      File.read(pid_file).strip.to_i rescue nil
    end
  end
end
