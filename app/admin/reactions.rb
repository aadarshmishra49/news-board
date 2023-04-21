ActiveAdmin.register Reaction do

  filter :user_email, as: :string
  scope :all
  
  scope :message, :default => true do |like|
    Reaction.message
  end
  scope :comment, :default => true do |like|
    Reaction.comment
  end




  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :user_email, :likeable_id, :likeable_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :likeable_id, :likeable_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
