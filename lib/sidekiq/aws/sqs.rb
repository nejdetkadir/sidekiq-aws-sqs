# frozen_string_literal: true

require_relative 'sqs/version'
require 'rails'
require 'aws-sdk-sqs'
require 'sidekiq'
require 'dry-configurable'

module Sidekiq
  module AWS
    module SQS
      extend Dry::Configurable

      setting :sqs_client, default: nil, reader: true
      setting :sqs_workers, default: [], reader: true
      setting :wait_time_seconds, default: 20, reader: true
      setting :max_number_of_messages, default: 10, reader: true
      setting :destroy_on_received, default: false, reader: true
      setting :logger, default: ::Sidekiq.logger, reader: true
    end
  end
end

require_relative 'sqs/rails/engine'
require_relative 'sqs/worker'
