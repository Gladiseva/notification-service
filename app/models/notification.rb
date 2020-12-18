class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  scope :unread, -> { where(read_at: nil) }
  scope :most_relevant, -> { order(read_at: :desc, created_at: :desc) }

  validates :recipient_id, :title, :description, presence: true
end
