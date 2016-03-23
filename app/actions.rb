helpers do
  # Helper method returns the current user if the user is logged in
  # Returns nil if the user is not logged in
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :songs
end

# when creating new songs the author can also create a new artist
get '/new' do 
  erb :new
end

post '/songs' do
  artist = Artist.where(name: params[:artist]).first_or_create
  # @song = Song.new(params)
   # {"artist"=>"Hello", "title"=>"Hello", "lyrics"=>"Helo", "url"=>"www.hello.com"}
  @song = Song.new({
    title: params[:title],
    genre: params[:genre],
    lyrics: params[:lyrics],
    url: params[:url]
    })
  @song.artist = artist
  @song.user = current_user
  if @song.save
    redirect '/songs'
  else
    erb :new
  end
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'show'
end

# How do I edit the below????
get '/show/:ketchup' do
  @songs = Song.where(:user_id => params[:ketchup])
  erb :usersongs
end

get '/signup' do
  @user = User.new
  erb :signup
end

post '/signup' do
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password]
    )
  if @user.save
    session[:user_id] = @user.id
    redirect '/songs'
  else
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  # find the user by email
  user = User.find_by(email: params[:email])

  # if the user was found, check that the password matches
  # Note: In a real application the password would not be stored in the database
  # Instead, you would store the hashed password when the user signs up.
  # Then, when the user logs in you hash the password and compare hashes.
  # Check out the bcrypt gem for how to generate and validate hashes.
  if user && user.password == params[:password]
    # Store the user_id in the session.
    # Any values you store in the session will persist from one request to another.
    # Later on, when we want to get the current user we can just look up the user from
    # the database.
    #     user = User.find(session[:user_id])
    session[:user_id] = user.id
    redirect '/new'
  else
    # Load the home page. 
    @message = "Invalid username or password."
    #~~~~~~~~~~ Need to change the redirect
    redirect "/songs?message=#{@message}"
  end
end

get '/logout' do
  # Remove the user_id from the session.
  session[:user_id] = nil
  #~~~~~~~~~~ Need to change the redirect
  redirect "/"
end
