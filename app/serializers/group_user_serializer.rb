class GroupUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :group_id, :created_at
  attribute :created_date do |group_user|
  group_user && group_user.created_at.strftime('%d/%m/%Y')
  end
end
