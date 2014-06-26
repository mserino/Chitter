module CheetHelper
	def add_cheet(text)
		visit '/'
		fill_in 'cheet', with: text
		click_button 'Post!'
	end
end