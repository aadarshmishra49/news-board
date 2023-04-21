module Api
    class MessagesController < Api::ApplicationController

        def index
            @messages=Message.all.order("created_at DESC")
            render json: @messages.map { |message|
            {
              id: message.id,
              author_id: message.author.id,
              category_id: message.category.id,
              title: message.title,
              description: message.description
            }
          }

          
            #render json: @messages
        end
        


        def show
            message=Message.where(id: params[:id])
            if message.present?
             render json: message
            else 
             render json: { message: "Record show not found" }, status:404
            end

            
        end

        def new
            @message=current_author.messages.build
            render json: {message: @messages}

        end

        def create
            
            @author = Author.find(doorkeeper_token.resource_owner_id)
            message=@author.messages.new(message_params)
            if message.save
                render json: message, status: :created

            else 
                render json: { error: message.errors.full_messages }, status: :unprocessable_entity

            end

        end

        def update
            #debugger
            message = Message.find_by(id: params[:id])

            if current_author.is_a? Author
              if message.author_id == doorkeeper_token.resource_owner_id
                if message.update(message_params)
                  render json: {message: "message #{message.id} is updated successfully"}
                else
                  render json: {message:"message not updated"}
                end
              else
                render json:{error:"unauthorized"},status: :unauthorized
              end
            else
              render json: {error:"You are not allowed to updatee"},status: 403
            end
          end
        
          
        
        
          def destroy
            #debugger
            message=Message.find_by(id: params[:id])
           if message.present?
            if current_author.is_a? Author
               if message.author_id == doorkeeper_token.resource_owner_id
  
                if message.destroy
                  render json: {message: "message deleted"}
                else
                  render json: {message:"Message not deleted"}
                end
              else
                 render json:{error:"unauthorized"},status: :unauthorized
              end
            else
              render json: {message:"You are not allowed to delete"},status: 403
            end
           else 
              render json: {message:"message-not-found"}
           end
          end
        


        private
        def message_params
            params.require(:message).permit(:title, :description,:category_id, :author_id )
        end 
        

    
    end
  end
  