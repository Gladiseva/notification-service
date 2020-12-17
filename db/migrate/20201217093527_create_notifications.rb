class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.datetime :created_at
      t.datetime :read_at
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
