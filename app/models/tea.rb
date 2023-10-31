class Tea < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
  
  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
