require 'websync'
require 'logger'
class ClientAgent < WebSync::ClientAgent

  ROOT = File.expand_path('../../', __FILE__)

  def logger
    @logger ||= begin 
      logger = Logger.new(File.join(ROOT, 'logs/client-agent.log'), 'monthly')
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
        logger.debug("User save-request received.")
        save(args["message"])
      end

      listen :working_dir_saved do |*args|
        logger.info("Working dir saved (#{working_dir.fs_dir}).")
      end

      listen :"deploy-request" do |*args|
        logger.debug("User deploy-request received.")
        sync_repo
      end

      listen :repository_synchronized do |*args|
        logger.info("Repository synchronized, notifying server now...")
        begin
          require 'http'
          res = Http.post("http://www.lemurierplatane.fr/websync/redeploy")
          logger.debug("Production notified: #{res}")
        rescue Exception => ex
          logger.error("Notification failed: #{ex.message}")
          raise
        end
      end

    end

end
