class Tutorial < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :tutorial_relationships
  has_many :buyers, :through => :tutorial_relationships, source: :user
  has_many :comments

  def check!
    self.checked = true
    self.save
  end

  def recheck!
    self.checked = false
    self.save
  end

  scope :checked, -> { where(checked: true) }

  scope :unchecked, -> { where(checked: false) }
end
