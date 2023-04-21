class Api::V1::CommentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  #before_action :doorkeeper_authorize!

  def index
    @comments=Comment.all.order("created_at DESC")
    render json: @comments

  end

  def create
    comment = Comment.new(comment_params)

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
    comment = Comment.find_by(id: params[:id])
    if comment.nil?
      render json: { message: "Record not found" }, status: :unprocessable_entity
    else
      if comment.update(comment_params)
        render json: comment, status: :ok
      else
        render json: { message: "Unable to update comment" }, status: :unprocessable_entity
      end
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

