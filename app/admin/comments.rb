ActiveAdmin.register Comment, as: 'UsersComment' do
    filter :message
    filter :user_email, as: :string
    filter :content
    # See permitted parameters documentation:
    # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
    #
    # Uncomment all parameters which should be permitted for assignment
    #
    # permit_params :name
    #
    # or
    #
    # permit_params do
    #   permitted = [:name]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
    # end
    controller do
        defaults resource_class: Comment, collection_name: 'comments', instance_name: 'comment'
    end
  end
  