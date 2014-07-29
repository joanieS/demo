ActiveAdmin.register Installation do

  permit_params :name,
                :customer_id

  form do |f|
    f.inputs 'Details' do
      #f.input :customer_id, :label => 'Customer', :as => :select, :collection => Customer.all
      f.input :name
    end
    f.actions
  end


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
