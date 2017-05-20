class Photo < ApplicationRecord
  mount_uploader :file_name, ImageUploader
end
