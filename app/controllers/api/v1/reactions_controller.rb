class Api::V1::ReactionsController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def index
    @reactions=Reaction.all.order("created_at DESC")
    render json: {reaction: @reactions}

  end

  def create
    reaction=Reaction.new(reaction_params)
    if reaction.save
      render json: reaction, status: :created
    else
      render json: { error: reaction.errors.full_messages }, status: :unprocessable_entity

    end
    
  end
  def new
  end


  def destroy
    reaction=Reaction.find(params[:id])
    likeable=reaction.likeable
    reaction.destroy
    render json: {reaction: "deleted"}

    
  end

  def show
     reaction=Reaction.find(params[:id])
      user=reaction.user
      render json: user

  end

  private

  def reaction_params
    params.require(:reaction).permit(:user_id, :likeable_id, :likeable_type)
  end

end
