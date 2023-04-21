ActiveAdmin.register Message do


filter :title
filter :category_name, as: :string
filter :author_id, as: :select, collection: -> { Author.all.map { |a| [a.email, a.id] } }

#filter :comment, as: :select, collection: -> { Message.comment.all.map { |u| [u.content, u.id] } }, multiple: true

index do
  selectable_column
  column :id
  column :title
  column :author
  column :category_id
  

  actions

end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :title, :description, :author_id, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :author_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
