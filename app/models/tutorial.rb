class Tutorial < ApplicationRecord
  belongs_to :user

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
