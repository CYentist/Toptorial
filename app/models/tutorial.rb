class Tutorial < ApplicationRecord
  belongs_to :user
  has_many :tutorial_relationships
  has_many :buyers, :through => :tutorial_relationships, source: :user

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
