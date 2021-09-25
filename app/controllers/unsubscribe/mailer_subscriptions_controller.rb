require_dependency "unsubscribe/application_controller"

module Unsubscribe
  class MailerSubscriptionsController < ApplicationController
    before_action :set_owner, only: [:show, :create, :update]
    before_action :set_mailer, only: [:show]

    def show
    end

    def create
      @mailer = Unsubscribe::MailerSubscription.new(mailer_subscription_params)

      if @owner != @mailer.owner
        redirect_to(
          mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: params[:mailer_subscription][:mailer]),
          alert: "You are not authorized to perform this action."
        ) and return
      end

      if @mailer.save
        redirect_to(
          mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: params[:mailer_subscription][:mailer]),
          notice: "Settings updated."
        )
      else
        redirect_to(
          mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: params[:mailer_subscription][:mailer]),
          alert: @mailer.errors.full_messages.to_sentence
        )
      end
    end

    def update
      @mailer = Unsubscribe::MailerSubscription.find(params[:mailer_subscription_id])

      if @owner != @mailer.owner
        redirect_to(
          mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: @mailer.mailer),
          alert: "You are not authorized to perform this action."
        ) and return
      end

      if @mailer.toggle!(:subscribed)
        redirect_to mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: @mailer.mailer), notice: "Settings updated."
      else
        redirect_to mailer_subscription_path(@owner.to_sgid_for_mailer_subscription, mailer: @mailer.mailer), alert: @mailer.errors.full_messages.to_sentence
      end
    end

    private

    def set_owner
      @owner = GlobalID::Locator.locate_signed(params[:id], for: :mailer_subscription)
      raise ActiveRecord::RecordNotFound if @owner.nil?
    end

    def set_mailer
      @mailer = @owner.mailer_subscriptions.find_or_initialize_by(mailer: params[:mailer])
    end

    def mailer_subscription_params
      params.require(:mailer_subscription).permit(:owner_id, :owner_type, :subscribed, :mailer)
    end
  end
end
