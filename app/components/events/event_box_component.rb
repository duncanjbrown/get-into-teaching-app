module Events
  class EventBoxComponent < ViewComponent::Base
    attr_reader :title, :event, :type, :online, :virtual

    delegate :format_event_date, :name_of_event_type, :event_type_color, :safe_format, to: :helpers
    alias_method :online?, :online
    alias_method :virtual?, :virtual

    def initialize(event)
      @event       = event
      @title       = event.name
      @type        = event.type_id
      @online      = event.is_online
      @virtual     = event.is_virtual
    end

    def datetime
      format_event_date(event, stacked: true)
    end

    def type_name
      t("event_types.#{type}.name.singular")
    end

    def type_color
      event_type_color(type)
    end

    def divider
      event_type_divider_class = %(event-box__divider--#{type_name.parameterize})

      tag.hr(class: (%w[event-box__divider] << event_type_divider_class).compact)
    end

    def event_type_icon
      icon_class = %(icon-#{type_name.parameterize})

      tag.div(class: [event_box_footer_icon_class, icon_class])
    end

    def online_icon
      icon_class = virtual? ? "icon-moved-online-event" : "icon-online-event"
      colour_class = "#{icon_class}--#{type_color}"

      tag.div(class: [event_box_footer_icon_class, icon_class, colour_class])
    end

    def online_text
      return "Event has moved online" if virtual?

      "Online event"
    end

  private

    def event_box_footer_icon_class
      "event-box__footer__icon"
    end
  end
end
