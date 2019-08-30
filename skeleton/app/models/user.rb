class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true
  after_initialize :ensure_session_token
  validate :password_presence
  validates :password, length: { minimum: 6, allow_nil: true}

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)
    return user if user && user.is_password?(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password_presence
    errors[:password_digest] << "Password can't be blank!" unless password_digest.present?
  end

  def ensure_session_token
    self.session_token = User.generate_session_token unless self.session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end  

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end