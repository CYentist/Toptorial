# == Schema Information
#
# Table name: tutorials
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  checked     :boolean          default("f")
#  description :text
#  image       :string
#  price       :integer
#

class Tutorial < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :tutorial_relationships
  has_many :buyers, :through => :tutorial_relationships, source: :user
  has_many :comments
  acts_as_votable

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
