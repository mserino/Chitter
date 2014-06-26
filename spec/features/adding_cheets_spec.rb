require 'spec_helper'
require_relative 'helpers/user_helpers'
require_relative 'helpers/cheet_helper'

include UserHelper
include CheetHelper

feature 'User adds a new post' do
	before(:each) do
		User.create(:email => 'test@test.com',
								:name => 'test',
								:username => 'testtt',
								:password => 'testfirst!',
								:password_confirmation => 'testfirst!')
	end

	scenario 'while not being signed in' do
		expect(Cheet.count).to eq(0)
		visit '/'
		expect(page).to have_content("You must be logged in to add a cheet")
	end

	scenario 'when logged in and browsing the homepage' do
		expect(Cheet.count).to eq(0)
		sign_in('test@test.com', 'testfirst!')
		add_cheet('some text')
		expect(Cheet.count).to eq(1)
		post = Cheet.first
		expect(post.cheet).to eq('some text')
	end

	scenario 'the cheet is empty' do
		sign_in('test@test.com', 'testfirst!')
		add_cheet('')
		expect(page).to have_content('You cannot submit an empty cheet')
	end

	scenario 'and it appears on the page' do
		sign_in('test@test.com', 'testfirst!')
		add_cheet('Hello I am Marge')
		expect(page).to have_content('Hello I am Marge')
	end
end