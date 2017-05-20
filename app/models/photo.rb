class Photo < ApplicationRecord
  mount_uploader :file_name, ImageUploader
  belongs_to :user
end
