post '/new_cheet' do
	current_user.cheets.create!(cheet: params[:cheet])
	# @cheets = Cheet.all
	# erb :index, :layout => :layout
	redirect to '/'
end