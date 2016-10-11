require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_new_token, on: :create

  def self.authenticate(credentials)
    user = User.find_by_email(credentials[:email])
    user if user.present? && user.validate(credentials[:password])
  end

  def refresh_token!
    generate_new_token
    self.save!
    self
  end

  private

  def generate_new_token
    # byebug
    new_token = ''
    begin
      new_token = SecureRandom.hex
    end while (new_token.blank? || self.class.exists?(token: new_token))
    self.token = new_token
  end
end
