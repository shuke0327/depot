require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "product attribute must not be empty" do
    product = Product.new
	assert product.invalid?
	assert product.errors[:title].any?
	assert product.errors[:description].any?
	assert product.errors[:price].any?
	assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
    product = Product.new(:title   => 'My Book Title',
	                      :description => 'yyy',
						  :image_url => 'zzz.jpg')
	product.price = -1
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 0
	assert product.invalid?
	assert_equal "must be reater than or equal to 0.01", product.errors[:price].join('; ')

	product.price = 1
	assert product.valid?
  end

  def new_product(image_url) 
    Product.new(:title => 'My Book Title',
	            :description => 'yyy',
				:price => 23,
				:image_url => image_url)
  end
  
  test "image url" do
    ok = %w{fred.gif nma.gif yes_it_is.jPg me.png whonews.Gif
	        http://2/3/4/5/fred.gif}
	bad = %w{fred.doc fred.gif/more fred.gif.more}

	ok.each do |name|
	  assert  new_product(name).valid?, "#{name} shouldn't be invalid"
	end

	bad.each do |name|
	  assert new_product(name).invalid?, "#{name} should't be valid"
	end
   end


end
