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

      def customers
        @customers ||= event.customers
      end

      def menu
        @menu ||= find_menu event
      end

      private

      def find_info event
        @info = event.info || Info.new(event: event)
      end

      def find_menu event
        @menu = event.menu || Menu.new(event: event)
      end
    end
  end

  def event_details event
    @event_details ||= EventHandler.new event
  end
end
