ActiveAdmin.register Offer do
  permit_params :name, :description, :picture

  index do
    selectable_column
    id_column
    column :name do |offer|
      link_to offer.name, admin_offer_path(offer)
    end
    column :description
    column :picture do |img|
      image_tag img.picture, :size => "150x140"
    end
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "Offer Details" do
      f.input :name
      f.input :description
      f.input :picture
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :picture do
        image_tag offer.picture, :size => "260x180"
      end
      row :created_at
    end
  end

end
