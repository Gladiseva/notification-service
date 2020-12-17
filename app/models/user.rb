class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, foreign_key: :recipient_id

  def admin?
    has_role?(:admin)
  end

  def client?
    has_role?(:client)
  end

end
