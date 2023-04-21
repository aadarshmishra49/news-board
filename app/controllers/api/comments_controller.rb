module Api
    class CommentsController < Api::ApplicationController
        def index
            @comments=Comment.all.order("created_at DESC")
            render json: @comments
        
        end
        def new
          @comment=current_user.comments.build
          render json: {message: @comment}

        end

          def create 
            #debugger
            @user = User.find(doorkeeper_token.resource_owner_id)
            comment=@user.comments.new(comment_params)
        
            if comment.save
              render json: comment, status: :created
        
            else
              render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
        
            end
          end
        
          def show 
            comment= Comment.where(id: params[:id])
            render json: comment
          end
        
          def edit
            
          end

          def update
            #debugger
            comment = Comment.find_by(id: params[:id])

            if current_user.is_a? User
              if comment.user_id == doorkeeper_token.resource_owner_id
                if comment.update(comment_params)
                  render json: {message: "comment #{comment.id} is updated successfully"}
                else
                  render json: {message:"comment not updated"}
                end
              else
                render json:{error:"unauthorized"},status: :unauthorized
              end
            else
              render json: {error:"You are not allowed to updatee"},status: 403
            end
          end
        
        
          def destroy
        
            comment=Comment.find(params[:id])
        
            comment.destroy
            render json: {comment: "Deleted"}
        
        
          end
        
        
          private
          def comment_params
            params.require(:comment).permit(:content, :message_id, :user_id)
          end
        
    end
end