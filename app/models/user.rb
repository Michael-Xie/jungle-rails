class User < ActiveRecord::Base
  has_secure_password
  validates :email, {uniqueness: {case_sensitive: false}, presence: true }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 6}

  before_save :downcase_email

  def downcase_email
     self.email.downcase!
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    return user && user.authenticate(password)? user: nil
  end

end
