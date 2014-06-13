require 'bundler'
Bundler.setup

require 'logger'
require 'yaml'
require 'ldap/server'

module LDAPToRadius
  extend self

  class Operation

    class UnimplementedOperationError < StandardError; end

    private
    def method_missing(name, *args, &block)
      fail UnimplementedOperationError, "#{name} #{args.join}"
    end
  end

  DEFAULT_CONFIG_FILE = File.join(File.dirname(__FILE__),
                                  '..',
                                  'config',
                                  'default.yml')

  def logger
    @logger ||= new_stdout_logger
  end

  def logger=(logger)
    @logger = logger
  end

  def start(config_file = DEFAULT_CONFIG_FILE)
    config = init_config(config_file)
    server = init_ldap_server(config)
    start_server(server)
  end

  def start_server(server)
    logger.debug "Starting LDAP server"
    server.run_tcpserver
    server.join
  end

  private
  def init_config(config_path)
    default_server_options = {
      :logger          => logger,
      :operation_class => Operation
    }

    logger.debug "Loading config"
    file_configs = YAML.load_file(config_path)
    default_server_options.merge(file_configs)
  end

  def init_ldap_server(options)
    LDAP::Server.new(options)
  end

  def new_stdout_logger
    Logger.new(STDOUT)
  end
end
