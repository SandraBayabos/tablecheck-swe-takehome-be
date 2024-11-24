ActiveAdmin.register AdminUser do
  # not showing in the menu
  # accessible via /admin/admin_users
  menu priority: 1
  permit_params :username, :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :created_at

  form do |f|
    f.inputs do
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :email, hint: 'Optional'
    end
    f.actions
  end

  member_action :delete_attachment, method: :delete do
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_back fallback_location: admin_root_path,
                  notice: "#{attachment.name&.capitalize} is deleted!"
  end
end
