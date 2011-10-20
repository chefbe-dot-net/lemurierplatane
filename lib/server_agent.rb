require 'websync'
require 'logger'
class ServerAgent < WebSync::ServerAgent

  ROOT = File.expand_path('../../', __FILE__)

  def logger
    @logger ||= begin 
      logger = Logger.new(File.join(ROOT, 'logs/server-agent.log'), 'monthly')
      logger.level = Logger::DEBUG
      logger
    end
  end

  def initialize(*args)
    super(*args)
    install_events
  end

  private

    def restart_application
      Bundle::with_original_env do
        Dir.chdir(ROOT) do
          logger.debug "[#{Time.now}] Executing bundle install"
          logger.debug `bundle install --deployment --local`
          `touch tmp/restart.txt`
        end
      end
    end

    def install_events

      listen :"redeploy-request" do |*args|
        logger.debug("[#{Time.now}] User redeploy-request received.")
        unless synchronize
          logger.info("[#{Time.new}] Nothing to redeploy for now.")
        end
      end

      listen :production_up_to_date do |*args|
        logger.info("[#{Time.now}] Working dir synchronized, restarting now...")
        restart_application
      end

    end

end
