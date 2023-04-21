class Api::V1::MessagesController < ApplicationController
 
  skip_before_action :verify_authenticity_token


  
  def index
    @messages=Message.all.order("created_at DESC")
    render json: @messages
  end

  def show
    message=Message.where(id: params[:id])
    if message.present?
      authors_id= message.pluck(:author_id)
      author = Author.find_by_id(authors_id)
      render json: author
    else 
      render json: { message: "Record not found" }, status:404
    end

    
  end

  def new
    @message=current_author.messages.build
    render json: {message: @messages}
  end

  def create
      #debugger
      message=Message.new(message_params)
      if message.save
        render json: message, status: :created

      else 
        render json: { error: message.errors.full_messages }, status: :unprocessable_entity

      end

  end


  def update
    
    message = Message.find_by(id: params[:id])
    
    if message.nil?
      render json: { message: "Record not found" }, status: :not_found
    elsif message.update(message_params)
      render json: message, status: :ok
    else 
      render json: { message: "Record not updated" }, status: :unprocessable_entity
    end
  end
  
  def destroy
    message=Message.find_by(params[:id])
    message.destroy
    render json: {message: "Deleted"}
  end

  def search
    message = Message.where('LOWER(title) LIKE ?', "%#{params[:title].downcase}%")
    render json: message
  end


  private
  def message_params
    params.require(:message).permit(:title, :description,:category_id, :author_id )
  end 
  

end



