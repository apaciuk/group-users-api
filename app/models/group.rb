class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_and_belongs_to_many :users, through: :group_users, class_name: "User", foreign_key: "user_id"

  validates :name, presence: true, uniqueness: true
end
