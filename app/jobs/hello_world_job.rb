require 'sidekiq-scheduler'
class HelloWorldJob < ApplicationJob
  queue_as :low_priority

  def perform(*args)
    # Do something later
    puts "hello world each minute! 🎉"

  end
end

