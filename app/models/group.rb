class Group < ActiveRecord::Base
  validates :title, :description, presence: true
  has_many :posts, dependent: :destroy

  # 這邊的 :owner 等同於 :user
  # :owner這個欄位可以任意指定名稱，但不管什麼名稱都還是對應到User這個model
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  # 驗證 "登入的使用者" 跟 "作者的 id" 是否一致
  def editable_by?(user)
    user && user == owner
  end

end
