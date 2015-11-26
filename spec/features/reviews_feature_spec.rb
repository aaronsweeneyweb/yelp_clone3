require 'rails_helper'

feature 'Reviewing' do

  before {Restaurant.create name: "KFC"}

  scenario 'allows user to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "So so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content "So so"
  end

  scenario 'cannot add two reviews' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "So so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content "So so"
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "Not so good"
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content "You have already reviewed this restaurant"
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'displays an everage rating for all reviews' do
    leave_review('So so', '3')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end
end
