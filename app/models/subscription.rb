class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :price, presence: true
  validates :frequency, presence: true 

  belongs_to :customer
  belongs_to :tea
end
