class UsersController < ApplicationController

  get '/signup' do
    if session[:id] != nil
      redirect to '/lineups'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == ''
      redirect to '/signup'
    end
    if params[:email] == ''
      redirect to '/signup'
    end
    if params[:password] == ''
      redirect to '/signup'
    end
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect to '/lineups'
  end

  get '/login' do
    if session[:id] != nil
      redirect to '/lineups'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password]) == false
      redirect to 'login'
    end
    session[:id] = @user.id
    redirect to '/lineups'
  end

  get '/logout' do
    if session[:id] == nil
      redirect to '/login'
    end
    session.clear
    redirect to '/login'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/' do
    erb :'/index'
  end

end
