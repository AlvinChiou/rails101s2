class Group < ActiveRecord::Base
  validates :title, :description, presence: true
end
