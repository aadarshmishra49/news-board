class UsersController < ApplicationController
    def index
        @users=User.all
    end


    def create
        #byebug
        @user=User.new(user_params)
        if @user.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
    def user_params
        params.permit(:email, :password)
    end

end
