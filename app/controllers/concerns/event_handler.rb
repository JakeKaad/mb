module EventHandler
  extend ActiveSupport::Concern

  included do
    class EventHandler
      attr_accessor :event

      def initialize(event)
        @event = event
      end

      def info
        @info ||= find_info event
      end

      private

      def find_info event
        @info = event.info
        @info ||= Info.new event: event
      end
    end
  end

  def event_details event
    @event_details ||= EventHandler.new event
  end
end
