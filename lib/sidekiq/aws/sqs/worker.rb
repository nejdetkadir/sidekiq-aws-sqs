# frozen_string_literal: true

require 'sidekiq/aws/sqs/helpers'

# rubocop:disable Layout/LineLength, Metrics/AbcSize
module Sidekiq
  module AWS
    module SQS
      module Worker
        include Sidekiq::AWS::SQS::Helpers

        def poller
          validate_sqs_options!

          @poller ||= SafePoller.poll do
            sqs_options_struct
              .client
              .receive_message(queue_url: sqs_options_struct.queue_url,
                               wait_time_seconds: sqs_options_struct.wait_time_seconds)
              .messages
              .each do |message|
              Sidekiq::AWS::SQS.logger.debug("Received message #{message.message_id} from #{sqs_options_struct.queue_url} for #{self}")

              perform_async(message.to_json)

              Sidekiq::AWS::SQS.logger.debug("Enqueued message #{message.message_id} from #{sqs_options_struct.queue_url} for #{self}")

              next unless need_to_destroy_on_received?

              sqs_options_struct.client.delete_message(queue_url: sqs_options_struct.queue_url,
                                                       receipt_handle: message.receipt_handle)

              Sidekiq::AWS::SQS.logger.debug("Deleted message #{message.message_id} from #{sqs_options_struct.queue_url} for #{self}")
            end
          end
        end

        def start_polling
          validate_sqs_options!

          Sidekiq::AWS::SQS.logger.debug("Starting polling for #{self}")

          @poller&.start || poller
        end

        def stop_polling
          validate_sqs_options!

          Sidekiq::AWS::SQS.logger.debug("Stopping polling for #{self}")

          @poller&.stop
        end

        def pause_polling
          validate_sqs_options!

          Sidekiq::AWS::SQS.logger.debug("Pausing polling for #{self}")

          @poller&.pause
        end

        def resume_polling
          validate_sqs_options!

          Sidekiq::AWS::SQS.logger.debug("Resuming polling for #{self}")

          @poller&.resume
        end

        def running?
          @poller&.running? || false
        end

        def paused?
          @poller&.paused? || false
        end

        def sqs_options(**options)
          @sqs_options = options || {}
        end
      end
    end
  end
end
# rubocop:enable Layout/LineLength, Metrics/AbcSize
