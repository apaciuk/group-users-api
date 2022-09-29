class GroupUser < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id", optional: true
  belongs_to :group, class_name: "Group", foreign_key: "group_id", optional: true
  before_validation :set_admin

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :role, presence: true

 enum role: {
    user: 0,
    admin: 1
  }
 

private 

  def set_admin   
    user = User.find_by(id: self.user_id)
    if user.admin?
      self.role = "admin"
    end
  end

  def assign_user_to_group(user, group)
    self.user_id = user.id
    self.group_id = group.id
    self.save
  end

end
