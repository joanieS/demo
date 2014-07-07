ActiveAdmin.register Beacon do

  permit_params :installation_id,
                :minor_id,
                :content,
                :content_type,
                :audio,
                :content_image,
  photos_attributes: [:url, :caption]

  form do |f|
    f.inputs 'Details' do
      f.input :installation_id, :label => 'Installation', :as => :select, :collection => Installation.all
      f.input :minor_id
      f.input :audio
      f.input :content_type, :label => 'Content Type', :as => :select, :collection => ["Web", "Image", "Web Video", "Local Video", "Photo Gallery"]
      f.input :content, :as => :string
      f.has_many :photos do |photo_form|
        photo_form.inputs do
          photo_form.input :url
          photo_form.input :caption
        end
      end
      f.input :content_image, :as => :file
    end
    f.actions
  end

   index do
    column :id
    column :minor_id
    column :content_type
    column :content
    column :content_image
    column :audio
    actions
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
