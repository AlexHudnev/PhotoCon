
ActiveAdmin.register Photo do

index do
  selectable_column
  column :photo_name
  column :photo do |pg|
    image_tag pg.photography
  end
  column :moderation do |pg|
    link_to 'Aprove', approve_admin_photo_path(pg)
  end
  actions
end

member_action :approve do

end

end
