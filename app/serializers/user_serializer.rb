class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :created_at 
  attribute :created_date do |user|
       user && user.created_at.strftime('%d/%m/%Y')
  end 
end  # class UserSerializer, multiple records by, UserSerializer.new(resource).serializable_hash[:data].map{|data| data[:attributes]}
