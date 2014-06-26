require 'spec_helper'
require 'launchy'
require_relative 'helpers/user_helpers'
require_relative 'helpers/cheet_helper'

include UserHelper
include CheetHelper

feature 'User signs up' do

	scenario 'when being logged out' do
		visit '/'
		expect(lambda {sign_up}).to change(User, :count).by(1)
		expect(page).to have_content("Welcome Josh88")
		expect(User.first.email).to eq("josh@josh.com")
	end

	scenario 'with a password that doesn\'t match' do
		expect(lambda { sign_up('a@a.com', 'aaa', 'bbb' 'password', 'wrongggg')}).to change(User, :count).by(0)
		expect(current_path).to eq('/sign_up')
		expect(page).to have_content('Your passwords don\'t match')
	end

	scenario 'with an email that is already registered' do
		expect(lambda { sign_up }).to change(User, :count).by(1)
		expect(lambda { sign_up }).to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

	scenario 'with a nickname that is already in use' do
		expect(lambda {sign_up('e@e.com', 'name', 'username', 'password', 'password')}).to change(User, :count).by(1)
		expect(lambda {sign_up('b@b.com', 'different_name', 'username', 'password', 'password')}).to change(User, :count).by(0)
		expect(page).to have_content("Username is already taken")
	end

	scenario 'with empty name' do
		expect(lambda {sign_up('email@email.com', '', 'username', 'password', 'password')}).to change(User, :count).by(0)
		expect(current_path).to eq('/sign_up')
		expect(page).to have_content('Name must not be blank')
	end

	scenario 'with empty username' do
		expect(lambda {sign_up('email@email.com', 'name', '', 'password', 'password')}).to change(User, :count).by(0)

		expect(current_path).to eq('/sign_up')
		expect(page).to have_content('Username must not be blank')
	end

	scenario 'password must be minimum 5 length' do
		expect(lambda {sign_up('email@email.com', 'name', 'username', '12', '12')}).to change(User, :count).by(0)
		expect(current_path).to eq('/sign_up')
		expect(page).to have_content('Password must be at least 5 characters long')
	end
end

feature 'User signs in' do

	before(:each) do
		User.create(:email => 'test@test.com',
								:name => 'test',
								:username => 'testtt',
								:password => 'testfirst!',
								:password_confirmation => 'testfirst!')
								#:password_token => ' '
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, testtt")
		sign_in('test@test.com', 'testfirst!')
		expect(page).to have_content("Welcome testtt")
	end

	scenario 'with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, testtt")
		sign_in('test@test.com', 'wrong!!!!')
		expect(page).not_to have_content("Welcome testtt")
		expect(page).to have_content("The email or password are incorrect")
	end
end

feature 'User signs out' do
	before(:each) do
		User.create(:email => 'test@test.com',
								:name => 'test',
								:username => 'testtt',
								:password => 'testfirst!',
								:password_confirmation => 'testfirst!')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'testfirst!')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")
		expect(page).not_to have_content("Welcome, testtt")
	end

	scenario 'and posts a cheet' do
		sign_up(email = 'josh@josh.com',
							name = 'Josh',
							username = 'Josh88',
					    password='testfirst!')
		visit '/'
		add_cheet('Hello I am Marge')
		expect(page).to have_content('posted by Josh88')		
	end

end