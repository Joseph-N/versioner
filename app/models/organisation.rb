class Organisation < ActiveRecord::Base
  has_many :users
  has_many :articles
  validates :name, presence: true, uniqueness: true
end
