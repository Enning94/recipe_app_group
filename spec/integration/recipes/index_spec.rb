require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)

    Recipe.create(name: 'Recipe 1', description: 'Description 1', user: @user, cooking_time: 10,
                  preparation_time: 10, public: true)
    Recipe.create(name: 'Recipe 2', description: 'Description 2', user: @user, cooking_time: 10,
                  preparation_time: 10, public: true)
  end

  it 'displays a list of recipes' do
    visit recipes_path

    expect(page).to have_content('Recipes List')
    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('Description 1')
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Description 2')
  end

  it "can click on the 'Add Recipe' button" do
    visit recipes_path
    within('.recipe-form') do
      click_link 'New Recipe'
    end
    expect(page).to have_current_path(new_recipe_path)
  end
end
