class CreateUnsubscribeMailerSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :unsubscribe_mailer_subscriptions do |t|
      t.references :owner, null: false, foreign_key: true
      t.boolean :subscribed
      t.string :mailer, null: false

      t.timestamps
    end
  end
end
