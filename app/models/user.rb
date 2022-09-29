class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
          :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :group_users, dependent: :destroy
  has_and_belongs_to_many :groups, through: :group_users, class_name: "Group", foreign_key: "group_id"
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

   enum admin: {
    user: 0,
    admin: 1
  }

  def jwt_payload 
    super.merge({ 'username' => username })
  end

end
