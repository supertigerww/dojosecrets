class Secret < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :delete_all

  validates :content, presence: true
end
