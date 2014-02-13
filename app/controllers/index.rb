get '/' do
  # Look in app/views/index.erb
  @user = session[:user_id]
  erb :index
end

get '/login' do
	erb :login
end	

get '/home' do
	@user = User.find(session[:user_id])
	@notes = @user.notes
	puts @notes.to_a
	erb :home
end

post '/sign-up' do
	@user = User.create(name: params[:name], password: params[:password])
	if @user.invalid?
		redirect '/error'
	else
		session[:user_id] = @user.id
		redirect '/home'
	end
end

post '/sign-in' do
	@user = User.find_by(name: params[:name], password: params[:password])
	if @user.invalid?
		redirect '/error'
	else
		session[:user_id] = @user.id
		redirect '/home'
	end
end

post '/notes/create' do
	user = User.find(session[:user_id])
	@note = user.notes.create(title: params[:title], content: params[:content])
	if @note.invalid? 
		redirect '/error'
	else
		redirect '/home'
	end
end

get '/error' do
	erb :error
end


get '/logout' do
	session.clear
	redirect '/'
end