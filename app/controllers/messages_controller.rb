class MessagesController < ApplicationController

    before_action :find_message,only: [:show, :edit, :update, :destroy]
    before_action :authenticate_author!, except: [:index, :show]
    before_action :set_categories

    
    def index
        @q = Message.ransack(params[:q])
        @messages=@q.result(distinct: true).order("created_at DESC").page(params[:page]).per(7)

    end
    def mymessages
    @q = Message.ransack(params[:q])
    @messages=@q.result(distinct: true).order("created_at DESC")

    end

    def show 
        
    end

    def new
        @message=current_author.messages.build
    end

    def create
        #debugger
        @message=current_author.messages.build(message_params)
        if @message.save
            redirect_to root_path
        else
            render 'new'
        end
    end
    def edit
        
    end

    def update
        if @message.update(message_params)
            redirect_to message_path
        else 
            render 'edit'
        end

    end

    def destroy
        @message.destroy
        redirect_to root_path
    end
     


    private
      def message_params
        params.require(:message).permit(:title, :description,:category_id, :author_id )
      end 
      def find_message
        @message=Message.find(params[:id])
      end

      def set_categories
        @categories=Category.all.order(:name)
      end
    

end
