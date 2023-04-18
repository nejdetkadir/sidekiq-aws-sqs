[![Gem Version](https://badge.fury.io/rb/sidekiq-aws-sqs.svg)](https://badge.fury.io/rb/sidekiq-aws-sqs)
![test](https://github.com/nejdetkadir/sidekiq-aws-sqs/actions/workflows/test.yml/badge.svg?branch=main)
![rubocop](https://github.com/nejdetkadir/sidekiq-aws-sqs/actions/workflows/rubocop.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version->=_2.7.0-blue.svg)

# Sidekiq::AWS::SQS

`sidekiq-aws-sqs` is a Sidekiq extension that simplifies the integration of AWS SQS queues with Sidekiq workers, by abstracting away the details of polling, processing and error handling of SQS messages. It aims to provide a reliable and flexible way to consume messages from SQS, while allowing the user to customize the polling behavior and SQS client options as needed.

At its core, `sidekiq-aws-sqs` uses the [SafePoller](https://github.com/nejdetkadir/safe_poller) gem to implement a background thread that polls messages from the specified SQS queue at a specified interval. The polling logic is encapsulated in a poll method that is meant to be called from a Sidekiq worker, passing a block of code that will process each message received. The poll method returns a handle to the SafePoller instance, which can be used to start, stop, pause or resume the polling process as needed. The polling process can also be configured to stop after a specified time or date, or to stop automatically when Sidekiq shuts down or terminates.

To use `sidekiq-aws-sqs` in a Sidekiq worker, you simply need to include the `Sidekiq::AWS::SQS` module and call the poll method with the desired options and block of code. You can also customize the SQS client and polling options by setting class-level variables, or by passing them as options to the poll method.

## Installation

Install the gem and add to the application's Gemfile by executing:
```bash
$ bundle add sidekiq-aws-sqs
```

Or add the following line to the application's Gemfile:
```ruby
gem 'sidekiq-aws-sqs', github: 'nejdetkadir/sidekiq-aws-sqs', branch: 'main'
```

If bundler is not being used to manage dependencies, install the gem by executing:
```bash
gem install sidekiq-aws-sqs
```


## Usage

```ruby
require 'sidekiq/aws/sqs'

class MyWorker
  include Sidekiq::Worker
  include Sidekiq::AWS::SQS::Worker

  sqs_options queue_url: 'https://sqs.foo.amazonaws.com/123/bar', wait_time_seconds: 20, destroy_on_received: true

  def perform(message)
    puts "Received message: #{message}"
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nejdetkadir/sidekiq-aws-sqs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nejdetkadir/sidekiq-aws-sqs/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

## Code of Conduct

Everyone interacting in the Sidekiq::Aws::Sqs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nejdetkadir/sidekiq-aws-sqs/blob/main/CODE_OF_CONDUCT.md).
