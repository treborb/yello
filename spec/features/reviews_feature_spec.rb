require 'rails_helper'

feature 'reviewing' do

  context 'leaving reviews' do

    before(:each) do
      sign_up
      create_restaurant
    end

    scenario 'allows users to leave a review using a form' do
      sign_out
      sign_up(name: "billy", email: 'billy@example.com')
      add_review
      expect(page).to have_content('so so')
    end

    scenario 'user cannot review their own restaurant' do
      visit '/restaurants'
      expect(page).not_to have_link("Review Nandos")
    end

    scenario 'user can only review each restaurant once' do
      sign_out
      sign_up(name: 'Johnny', email: 'johnny@example.com')
      add_review
      expect{add_review}.not_to change{Review.all.length}
      expect(page).to have_content "You've already reviewed this restaurant"
    end

    scenario 'user can only review resturants when logged on' do
      sign_out
      expect(page).not_to have_content "Review Nandos"
    end

    scenario "users are redirected if they try to visit review url for restaurants they do own" do
      visit "/restaurants/#{Restaurant.first.id}/reviews/new"
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "You can't review your own restaurant"
    end

  end

  context 'deleting reviews' do

    before(:each) do
      sign_up
      create_restaurant
      sign_out
      sign_up(name: 'Johnny', email: 'johnny@example.com')
      add_review
    end

    it 'users can delete their own reviews' do
      visit "/restaurants/#{Restaurant.first.id}"
      click_link 'Delete review'
      expect(page).to have_content("Review deleted successfully")
    end

  end

  context 'editing reviews' do

    before(:each) do
      sign_up
      create_restaurant
      sign_out
      sign_up(name: 'Johnny', email: 'johnny@example.com')
      add_review
    end

    it 'users can edit their own reviews' do
      edit_review
      expect(page).to have_content("Review edited successfully")
      visit "/restaurants/#{Restaurant.first.id}"
      expect(page).to have_content("Updated review: Awesome!")
    end

    scenario "users are redirected if they try to visit an edit review url for reviews they did not write" do
      sign_out
      visit "/restaurants/#{Restaurant.first.id}/reviews/#{Review.first.id}/edit"
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "You can only edit reviews that you wrote"
    end

  end
end
