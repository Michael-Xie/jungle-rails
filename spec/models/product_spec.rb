require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid with valid attributes" do
      @category = Category.new(name: "Test Category")
      @product = Product.new(name: "name", price_cents:1099, quantity:10, category:@category)
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @category = Category.new(name: "Test Category")
      @product = Product.new(name: nil, price_cents:1099, quantity:10, category:@category)
      expect(@product).to_not be_valid
      # expect(@product.errors.full_messages.length()).to be >= 1
      expect(@product.errors.full_messages).to include("Name can't be blank")

    end

    it "is not valid without a price" do
      @category = Category.new(name: "Test Category")
      @product = Product.new(name: "name", price_cents:nil, quantity:10, category:@category)
      expect(@product).to_not be_valid
      # p @product.errors.full_messages
      expect(@product.errors.full_messages.length()).to be >= 1
    end

    it "is not valid without a quantity" do
      @category = Category.new(name: "Test Category")
      @product = Product.new(name: "name", price_cents:1099, quantity:nil, category:@category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.length()).to be >= 1
    end

    it "is not valid without a category" do
      @category = Category.new(name: "Test Category")
      @product = Product.new(name:"name", price_cents:1099, quantity:10, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.length()).to be >= 1
    end
  end
end

# validates :name, presence: true
# validates :price, presence: true
# validates :quantity, presence: true
# validates :category, presence: true
