class ReactionsController < ApplicationController

   def create
     @reaction=current_user.reactions.new(reaction_params)
     if !@reaction.save
        flash[:notice]=@reaction.errors.full_messages.to_sentence
     end
     redirect_back(fallback_location:messages_url)
   end

   def destroy
     @reaction=current_user.reactions.where(id: params[:id]).first
     likeable=@reaction.likeable
     @reaction.destroy
     redirect_back(fallback_location:messages_url)

   end
   def show

   end

   private

   def reaction_params
     params.require(:reaction).permit(:likeable_id, :likeable_type, :user_id, :user_email)
   end

end


