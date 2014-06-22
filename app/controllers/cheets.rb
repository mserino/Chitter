post '/new_cheet' do
	cheet = params[:cheet]
	Cheet.create(:cheet => cheet)
	redirect to('/')
end