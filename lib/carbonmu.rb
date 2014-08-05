require 'rubygems'
require 'bundler/setup'

require 'require_all'
require 'colorize' # An exception to our require-where-used rule, since it's likely to be used many places.
require_all 'lib'

Celluloid::ZMQ.init

module CarbonMU
  class << self
    attr_accessor :configuration
    attr_accessor :overlord_receive_port
    attr_reader :overlord_supervision_group, :server_supervision_group
  end
  self.configuration = Configuration.new

  def self.configure
    yield self.configuration
  end

  def self.start
    @overlord_supervision_group = OverlordSupervisionGroup.run
  end

  def self.start_in_background
    @overlord_supervision_group = OverlordSupervisionGroup.run!
  end

  def self.start_server
    @server_supervision_group = ServerSupervisionGroup.run
  end

  def self.start_server_in_background
    @server_supervision_group = ServerSupervisionGroup.run!
  end

  def self.shutdown
    @overlord_supervision_group.finalize
    @server_supervision_group.finalize
  end
end

