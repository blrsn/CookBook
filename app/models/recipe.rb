class Recipe < ActiveRecord::Base
  #validations
  validates :title, :description, :image,presence: true
  
  #associations
  has_many :ingredients
  has_many :directions
  
  #image validations
  has_attached_file :image, styles: { :medium => "400x400#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image,less_than: 2.megabytes, allow_nil: true
  
  accepts_nested_attributes_for :ingredients,
                                reject_if: proc{ |attributes| attributes['name'].blank?},
                                allow_destroy: true  
  accepts_nested_attributes_for :directions,
                                reject_if: proc{ |attributes| attributes['step'].blank?},
                                allow_destroy: true
  
end
