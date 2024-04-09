class Message < ApplicationRecord
  belongs_to :end_user
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy
  
  #通知
  after_create do
    create_notification(end_user_id: self.room.entries.where.not(end_user_id: self.end_user_id).first.end_user_id)
  end

  def notification_message
    "#{end_user.name}さんからメッセージが届いています"
  end

  def notification_path
    "/rooms/#{room.id}"
  end

  validates :message, presence: true, length: { maximum: 140 }
end
