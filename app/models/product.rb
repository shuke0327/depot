class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title
  validates :title, :description, :image_url, :price, :presence=>true
  validates :title, :uniqueness=>true
  validates :title, :length => {:minimum=>10,:message=>"you sucked,boy"}
  validates :price, :numericality=>{:greater_than_or_equal_to=>0.01}
  validates :image_url, :format=>{
    :with => %r{\.(gif|jpg|png)$}i,
	:message => 'must be a URL for GIF, JPG, or PNG.'
  }
end
