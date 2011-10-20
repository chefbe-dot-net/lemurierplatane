require 'websync'
require 'logger'
class ClientAgent < WebSync::ClientAgent

  def logger
    @logger ||= begin 
      path = File.expand_path('../../logs/client-agent.log', __FILE__)
      logger = Logger.new(path, 'monthly')
      logger.level = Logger::DEBUG
      logger
    end
  end

  def initialize(*args)
    super(*args)
    install_events
  end

  private 

    def install_events

      listen :"save-request" do |ag,evt,args|
        logger.debug("[#{Time.now}] User save-request received.")
        save(args["message"])
      end

      listen :working_dir_saved do |*args|
        logger.info("[#{Time.now}] Working dir saved (#{working_dir.fs_dir}).")
      end

      listen :"deploy-request" do |*args|
        logger.debug("[#{Time.now}] User deploy-request received.")
        sync_repo
      end

      listen :repository_synchronized do |*args|
        logger.info("[#{Time.now}] Repository synchronized, notifying server now...")
        begin
          require 'http'
          res = Http.post("http://www.lemurierplatane.fr/redeploy")
          logger.debug("[#{Time.now}] Production notified: #{res}")
        rescue Exception => ex
          logger.error("[#{Time.now}] Notification failed: #{ex.message}")
          raise
        end
      end

    end

end
