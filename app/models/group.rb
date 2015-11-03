class Group < ActiveRecord::Base
  validates :title, :description, presence: true
  has_many :posts
end
