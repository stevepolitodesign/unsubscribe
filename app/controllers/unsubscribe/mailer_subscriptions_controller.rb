require_dependency "unsubscribe/application_controller"

module Unsubscribe
  class MailerSubscriptionsController < ApplicationController
    before_action :set_owner, only: [:show, :create]
    before_action :set_mailer, only: [:show]

    def show
    end

    def create
      @mailer = Unsubscribe::MailerSubscription.new(mailer_subscription_params)

      # TODO: redirect_to :show if @owner != @mailer.owner
      if @mailer.save
        redirect_to mailer_subscription_path(@owner.to_sgid(for: :mailer_subscription), mailer: params[:mailer_subscription][:mailer]), notice: "Settings updated."
      else
        redirect_to mailer_subscription_path(@owner.to_sgid(for: :mailer_subscription), mailer: params[:mailer_subscription][:mailer]), alert: @mailer.errors.full_messages.to_sentence
      end
    end

    private

    def set_owner
      @owner = GlobalID::Locator.locate_signed(params[:id], for: :mailer_subscription)
    end

    def set_mailer
      @mailer = @owner.mailer_subscriptions.find_or_initialize_by(mailer: params[:mailer])
    end

    def mailer_subscription_params
      params.require(:mailer_subscription).permit(:owner_id, :owner_type, :subscribed, :mailer)
    end

  end
end
