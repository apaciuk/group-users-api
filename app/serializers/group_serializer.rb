class GroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :created_at
  attribute :created_date do |group|
    group && group.created_at.strftime('%d/%m/%Y')
  end
end
