require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page by clicking on a product", type: :feature, js: true do

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
    first('.product').click_on "Details"
    sleep(5)

    #DEBUG
    # save_screenshot
    # puts page.html

    #VERIFY
    expect(page).to have_css 'section.products-show'
    expect(page).to have_css 'article.product-detail'
  end

end