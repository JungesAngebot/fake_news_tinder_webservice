Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.keep_original_rails_log = true
  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"

  config.lograge.custom_options = lambda do |event|
    params_exceptions = %w(controller action format id)
    opts = {
        params: event.payload[:params].except(*params_exceptions),
        time: event.time,
    }
    if event.payload[:exception]
      opts[:stacktrace] = Array(event.payload[:stacktrace]).to_json
    end
    opts
  end

  config.lograge.formatter = Lograge::Formatters::Logstash.new
end

module ActiveSupport
  module Notifications
    # Instrumenters are stored in a thread local.
    class Instrumenter
      attr_reader :id

      def initialize(notifier)
        @id       = unique_id
        @notifier = notifier
      end

      # Instrument the given block by measuring the time taken to execute it
      # and publish it. Notice that events get sent even if an error occurs
      # in the passed-in block.
      def instrument(name, payload = {})
        start name, payload
        begin
          yield payload
        rescue Exception => e
          payload[:exception] = [e.class.name, e.message]
          payload[:exception_object] = e
          payload[:stacktrace] = e.backtrace
          raise e
        ensure
          finish name, payload
        end
      end
    end
  end
end
