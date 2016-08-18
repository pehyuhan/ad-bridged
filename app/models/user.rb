class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of   :name, :email, :password
  validates_format_of     :email, with: /@/
  validates_uniqueness_of :email, case_sensitive: false
  validates_length_of     :password, minimum: 6

  before_save { self.email = email.downcase }
end