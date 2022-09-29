class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group, only: [:index, :show]
    respond_to :json 

    def index(resource, _opts = {})
        render json: {
        status: {code: 200, message: 'Groups retrieved sucessfully.'},
        data: GroupSerializer.new(resource).serializable_hash[:data][:attributes]
    }
    end

    def show_group  
        render json: {
        status: {code: 200, message: 'Group retrieved sucessfully.'},
        data: GroupSerializer.new(@group).serializable_hash[:data][:attributes]
    }
    end
    
    private

    def set_group 
        @group = Group.find(params[:id])
    end 

end


