require 'rails_helper'

feature "User can sign in and out" do
  context "User not sign in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end
  context "User signed in on homepage" do

    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see sign out link" do
      visit "/"
      expect(page).to have_link('Sign out')
    end

    it "should not see sign in link and a sign up link" do
      visit "/"
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end

  context "User is not signed in anywhere" do
      it "when trying to add a restaurant should redirect a user to the login page" do
        visit '/'
        click_link("Add a restaurant")
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
  end

  context "User can only edit / delete restaurants they have created" do
    it "raises error " do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link('Sign out')
      click_link('Sign up')
      fill_in('Email', with: 'test2222@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Delete KFC')
      expect(page).not_to have_content('Restaurant deleted successfully')
      expect(page).to have_content('You are not the owner of this restaurant!')
      click_link("Edit KFC")
      fill_in "Name", with: "Fried Chicken"
      click_button("Update Restaurant")
      expect(page).not_to have_content('Restaurant updated successfully')
      expect(page).to have_content('You are not the owner of this restaurant!')
    end
  end
end
