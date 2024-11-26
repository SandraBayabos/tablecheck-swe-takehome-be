ActiveAdmin.register Setting do
  menu priority: 1
  
  permit_params :key, :value

  index do
    selectable_column
    id_column
    column :key
    column :value
    actions
  end

  form do |f|
    f.inputs do
      f.input :key
      f.input :value
    end
    f.actions
  end
end
