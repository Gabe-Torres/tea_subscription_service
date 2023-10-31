class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :status, presence: true
  validates :price, presence: true
  validates :frequency, presence: true 

  belongs_to :customer
  belongs_to :tea
end
