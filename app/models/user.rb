class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true 
  validates :password, presence: true, on: :create, length: {minimum: 3}

  before_save :generate_slug 

  def admin?
    self.role.to_s.to_sym == :admin
  end

  def moderator?
    self.role == 'moderator'
  end

  set_slug_column_name :username

end