class User < ActiveRecord::Base
  require 'securerandom'
  include BCrypt

  validates :email, presence: true, uniqueness: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(email, password)
    @user = User.find_by(email: email)
    return @user if @user && @user.is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(128)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest) == password
  end
end
