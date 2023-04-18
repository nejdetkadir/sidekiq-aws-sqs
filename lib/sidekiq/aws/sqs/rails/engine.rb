# frozen_string_literal: true

module Sidekiq
  module AWS
    module SQS
      module Rails
        class Engine < ::Rails::Engine
          isolate_namespace Sidekiq::AWS::SQS

          config.after_initialize do
            ::Sidekiq.configure_server do |config|
              config.on(:shutdown) do
                ::Sidekiq::AWS::SQS.config.sqs_workers.each(&:stop_polling)
              end

              config.on(:startup) do
                ::Sidekiq::AWS::SQS.config.sqs_workers.each(&:start_polling)
              end
            end
          end
        end
      end
    end
  end
end
