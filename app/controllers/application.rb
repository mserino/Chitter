get '/' do
	@cheets = Cheet.all
	erb :index, :layout => :layout
end