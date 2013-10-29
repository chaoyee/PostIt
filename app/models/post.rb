class Post < ActiveRecord::Base
  include Voteable
  include Sluggable  

  belongs_to :creator, class_name: "User", foreign_key: "user_id" 
  has_many   :post_categories
  has_many   :categories, through: :post_categories
  has_many   :comments
  has_many   :votes, as: :voteable

  validates :title, presence: true, uniqueness: true 
  validates :url, presence: true  

  before_save :generate_slug

  set_slug_column_name :title

end