class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar


  has_many :reviews, dependent: :destroy

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
end
