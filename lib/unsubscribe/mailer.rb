module Unsubscribe
  module Mailer
    extend ActiveSupport::Concern

    included do
      before_action :set_recipient
      before_action :set_unsubscribe_url, if: :should_unsubscribe?
      before_action :set_headers, if: :should_unsubscribe?
      after_action :prevent_delivery_if_recipient_opted_out, if: :should_unsubscribe?
    end

    class_methods do
      def unsubscribe_settings(name: nil, description: nil)
        cattr_accessor :unsubscribe_settings, default: {name: name, description: description}
        cattr_accessor :enabled, default: true
      end
    end

    private

    def prevent_delivery_if_recipient_opted_out
      mail.perform_deliveries = @recipient.subscribed_to_mailer? self.class.to_s
    end

    def set_recipient
      @recipient = params[:recipient]
    end

    def set_unsubscribe_url
      @unsubscribe_url = unsubscribe.mailer_subscription_url(@recipient.to_sgid_for_mailer_subscription, mailer: self.class)
    end

    def should_unsubscribe?
      @recipient.present? && @recipient.respond_to?(:subscribed_to_mailer?)
    end

    def set_headers
      headers["List-Unsubscribe"] = "<#{@unsubscribe_url}>"
    end
  end
end
