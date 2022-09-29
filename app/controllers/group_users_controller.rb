class GroupUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_user, only: [:create_group, :assign_users_to_group]
    respond_to :json 

  def admin_user 
      current_user = User.find_by(id: params[:user_id])
      unless current_user.admin? 
      flash[:danger] = "Only admin users can perform that action"
      redirect_to(root_url)
      end 
  end

  def create_group(resource, _opts = {})
        if admin_user
        render json: {
        status: {code: 200, message: 'Group created sucessfully.'},
        data: GroupSerializer.new(resource).serializable_hash[:data][:attributes]
      }
        else
        render json: {
        status: {message: "Group can only be created by admin user. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
        end
  end 
 
  def assign_user_to_group(resource, _opts = {}) 
    if admin_user
    render json: {
    status: {code: 200, message: 'User assigned to Group sucessfully.'},
    data: GroupUserSerializer.new(resource).serializable_hash[:data][:attributes]
  }
    else
    render json: {
    status: {message: "Users can only be assigned to Group by admin user. #{resource.errors.full_messages.to_sentence}"}
  }, status: :unprocessable_entity
    end
  end

end
