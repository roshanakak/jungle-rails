require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves when name, price, category and quantity are set' do 
      @category = Category.create(name: "Test")
      @product = @category.products.create(name: "Test", quantity: 1, price: 64.99)
      expect(@product).to be_valid

      @product.save!
      expect(@product.id).to be_present
    end

    it 'is invalid without a name' do 
      @category = Category.create(name: "Test")
      @product = @category.products.create(name: nil, quantity: 1, price: 64.99)
      expect(@product.errors.full_messages).to eql(["Name can't be blank"])
      expect(@product).to_not be_valid
    end

    it 'is invalid without a price' do 
      @category = Category.create(name: "Test")
      @product = @category.products.create(name: "Test", quantity: 1, price: nil)
      expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
      expect(@product).to_not be_valid
    end

    it 'is invalid without a quantity' do 
      @category = Category.create(name: "Test")
      @product = @category.products.create(name: "Test", quantity: nil, price: 64.99)
      expect(@product.errors.full_messages).to eql(["Quantity can't be blank"])
      expect(@product).to_not be_valid
    end

    it 'is invalid without a category' do 
      @product = Product.create(name: "Test", quantity: 1, price: 64.99, category: nil)
      expect(@product.errors.full_messages).to eql(["Category can't be blank"])
      expect(@product).to_not be_valid
    end

  end
end