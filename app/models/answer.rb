class Answer < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates :title, presence: true
  validates :price, presence: true

end
