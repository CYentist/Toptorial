class Order < ApplicationRecord
before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end
  belongs_to :user
  belongs_to :answers
  has_many :order_relationships
  has_many :askers, :through => :order_relationships, source: :user

  validates :question, presence: true
  validates :contact, presence: true


end
