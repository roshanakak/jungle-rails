require 'rails_helper'

RSpec.feature "Visitor adds an item to cart", type: :feature, js: true do

  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a specific product image or details and see the details" do

    #ACT
    visit root_path
    first('.product').click_on "Add"

    #DEBUG
    # Need this to make sure the puts and screenshots are taken for the right thing
    # sleep(2)
    # # puts page.html
    # save_screenshot

    #VERIFY
    expect(page).to have_content 'My Cart (1)'
  end

end