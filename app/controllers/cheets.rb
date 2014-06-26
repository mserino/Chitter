post '/new_cheet' do
	@cheet = current_user.cheets.create!(cheet: params[:cheet])
  if !@cheet.cheet.empty?
  	redirect to('/')
  else
    flash[:notice] = 'You cannot submit an empty cheet'
  	redirect to('/')
  end
end