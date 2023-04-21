class Api::V1::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def set_user
        @user=User.find(params[:id])
    end


    def index
        users=User.all
        render json: {user: users}
    end

    def new
        user=User.new
        render json: {user: user}
    end

    def create
        byebug
        user=User.new(user_params)      
        if user.save
            render json: {user: user}
        else
            render json: {message: "user not created"}
        end
    end


    def show
       user=User.find(params[:id])
      render json: user

    end

    def update
        if @user.update(user_params)
            render json: {message:"User updated",user: @user}
        else
            render json: {message: "User not updated"}
        end
        
    end


    def destroy
        user=User.find_by(params[:id])
        user.destroy
        render json: {message: "user deleted"}
    end

    
    private
    def user_params
        params.permit(:email, :password)
    end

end
