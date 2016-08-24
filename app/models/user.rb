class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of   :name, :email, :password
  validates_format_of     :email, with: /@/
  validates_uniqueness_of :email, case_sensitive: false
  validates_length_of     :password, minimum: 6
  
  has_many :posts, dependent: :destroy

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end  
end