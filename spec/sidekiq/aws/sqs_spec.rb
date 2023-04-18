# frozen_string_literal: true

RSpec.describe Sidekiq::AWS::SQS do
  it 'has a version number' do
    expect(Sidekiq::AWS::SQS::VERSION).not_to be nil
  end
end
