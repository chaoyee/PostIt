module Sluggable
  extend ActiveSupport::Concern 

  included do
    class_attribute :slug_column_name
  end

  def generate_slug
     sluggable_string = self.to_slug(self.send(self.slug_column_name)) 
     while self.class.where(slug: sluggable_string).first
       sluggable_string = sluggable_string + '1'
     end
     self.slug = sluggable_string
  end

  def to_slug(name)
    slug = name.gsub(/\s*[^A-Za-z0-9\.\-]\s*/, '_' ).gsub(/\A[_\.]+|[_\.]+\z/,"").downcase
    return slug
  end

  def to_param
    self.slug   
  end

  module ClassMethods 
    def set_slug_column_name(name)
      self.slug_column_name = name
    end
  end
end