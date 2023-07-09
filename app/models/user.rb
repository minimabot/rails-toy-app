class User < ApplicationRecord
  attr_accessor :activate_token, :remember_token, :password_reset_token

  before_save :convert_email_to_lower_case
  before_create :create_activate_digest

  validates :first_name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :nickname, presence: true, length: { minimum: 2, maximum: 255 }
  validates :email, presence: true, length: { minimum: 6, maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 255 }

  has_secure_password

  private

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def digest(value)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(value, cost:)
  end

  def convert_email_to_lower_case
    self.email = email.downcase
  end

  def create_activate_digest
    self.activate_token = generate_token
    self.activate_digest = digest(activate_token)
  end
end
