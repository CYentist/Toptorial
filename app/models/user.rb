class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tutorials
  has_many :tutorial_relationships
  has_many :paid_tutorials, :through => :tutorial_relationships, :source => :tutorial
  has_many :comments

  def admin?
    is_admin
  end

  def is_buyer?(tutorial)
    paid_tutorials.include?(tutorial)
  end

  def buy!(tutorial)
    paid_tutorials << tutorial
  end


end
