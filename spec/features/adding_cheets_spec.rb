require 'spec_helper'

feature 'User adds a new post' do

	scenario 'when browsing the homepage' do
		expect(Cheet.count).to eq(0)
		visit '/'
		add_cheet('some text')
		expect(Cheet.count).to eq(1)
		post = Cheet.first
		expect(post.cheet).to eq('some text')
	end

	def add_cheet(text)
		visit '/'
		fill_in 'cheet', with: text
		click_button 'Post!'
	end

end