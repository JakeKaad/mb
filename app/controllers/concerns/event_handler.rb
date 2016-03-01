module EventHandler
  extend ActiveSupport::Concern

  included do
    class EventHandler
      attr_reader :info
      attr_accessor :event

      def initialize(event)
        @event = event
        find_info event
      end

      private

      def find_info event
        @info = event.info
        @info ||= Info.new event: event
      end
    end
  end

  def handle event
    EventHandler.new event
  end
end
