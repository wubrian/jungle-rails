require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They should add product to cart" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    # commented out b/c it's for debugging only
    first('article.product').click_button('Add')
    expect(page).to have_text 'My Cart (1)'
    
    sleep 3
    save_screenshot 'cart.png'
  end
end
