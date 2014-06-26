get '/users/new' do
	@user = User.new
	erb :'users/new', :layout => :layout
end

post '/sign_up' do
	@user = User.new(:email => params[:email],
									 :name => params[:name],
									 :username => params[:username],
									 :password => params[:password],
									 :password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :'users/new', :layout => :layout
	end
end