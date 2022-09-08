class User < ApplicationRecord
  before_save{ email.downcase! }

  validates :name, presence: true,
    length: {maximum: Settings.user.length.name_max}
  validates :email, presence: true, length: {maximum:
    Settings.user.length.email_max},
    format: {with: Settings.user.email_regex},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.user.length.password_min}

  has_secure_password
end
