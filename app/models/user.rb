class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes
  has_many :secrets_liked, through: :likes, source: :secret

  email_regex = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :name, :birthdate, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }
  validate :validate_age

  private

  def validate_age
      if birthdate.present? && birthdate > DateTime.now.to_date
          errors.add(:birthdate, 'can not be future')
      end
  end
end
