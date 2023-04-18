# frozen_string_literal: true

require_relative 'lib/sidekiq/aws/sqs/version'

# rubocop:disable Layout/LineLength, Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = 'sidekiq-aws-sqs'
  spec.version = Sidekiq::AWS::SQS::VERSION
  spec.authors = ['nejdetkadir']
  spec.email = ['nejdetkadir.550@gmail.com']

  spec.summary = "sidekiq-aws-sqs is a Sidekiq extension that provides an easy way to poll and process messages from AWS SQS (Simple Queue Service) queues within a Sidekiq worker.
                 It uses the SafePoller gem under the hood to safely poll messages at a specified interval, and gracefully handle shutdown events to avoid losing messages.
                 It also integrates with Sidekiq's lifecycle events to start and stop the polling process automatically, and provides a simple interface to configure the SQS client and polling options."
  spec.description = spec.summary
  spec.homepage = "https://github.com/nejdetkadir/#{spec.name}"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency 'aws-sdk-sqs', '~> 1.53'
  spec.add_dependency 'dry-configurable', '~> 1.0', '>= 1.0.1'
  spec.add_dependency 'rails', '>= 6.0.0'
  spec.add_dependency 'safe_poller', '~> 0.0.1'
  spec.add_dependency 'sidekiq', '>= 7.0.0'
end
# rubocop:enable Layout/LineLength, Metrics/BlockLength
