require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They should navigate to product details" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    # commented out b/c it's for debugging only

    expect(page).to have_css 'article.product', count: 10
    first('article.product').click_link('Details')
    page.has_content?(@product.description)
    sleep 3
    save_screenshot 'product.png'
  end
end
