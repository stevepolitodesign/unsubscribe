class CreateUnsubscribeMailerSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :unsubscribe_mailer_subscriptions do |t|
      # Needs to be polymorphic to be flexible. Owner may not always be a User.
      t.references :owner, polymorphic: true, null: false
      t.boolean :subscribed
      t.string :mailer, null: false

      t.timestamps
    end

    # An owner should only have one Unsubscribe::MailerSubscription record per Mailer.
    add_index :unsubscribe_mailer_subscriptions, [:owner_id, :owner_type, :mailer], unique: true, name: :unsubscribe_owner_index
  end
end
