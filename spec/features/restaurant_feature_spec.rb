require 'rails_helper'
require 'web_helpers.rb'

feature 'restaurants' do

  before do
    user_login('lewis@gmail.com')
  end

  context 'no restaurants displayed on the page' do
    scenario 'should have option to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'Listing restaurants'
      expect(page).to have_link 'New restaurant'
      end
    end

  context 'restaurants are added' do
    scenario 'display the restaurants' do
      create_restaurant
      expect(page).to have_content('PizzaMamamia')
      expect(page).to have_link 'Show'
    end
  end

  context 'restaurants can be deleted' do
    scenario 'not display the deleted restaurant' do
      create_restaurant
      click_link 'Destroy'
      expect(page).not_to have_content('PizzaMamamia')
    end
  end


  context 'restaurants can be shown' do
    scenario 'display the restaurant details' do
      create_restaurant
      click_link 'Show'
      expect(page).to have_content('PizzaMamamia')
      expect(page).not_to have_content('German Pizza')
      expect(page).to have_link 'Back'
    end
  end

  context 'can be created' do
    scenario 'fill in the form with the restaurant name and description' do
      create_restaurant
      click_link 'New restaurant'
      fill_in 'restaurant[name]', with: 'Great Pasta'
      fill_in 'restaurant[description]', with: 'The best pasta from Portugal'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Great Pasta'
    end
  end

  context 'gives invalid restaurant' do
    scenario 'does not let you submit a name that is less than 1 character' do
      visit '/restaurants'
      click_link 'New restaurant'
      fill_in 'restaurant[name]', with: ''
      click_button 'Create Restaurant'
    expect(page).to have_content 'error'
    end
  end


end
