class UsersController < ApplicationController

  get '/users/:id' do
    if !logged_in?
      redirect '/lineups'
    end

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/lineups'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/lineups'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:empty_fields] = "Please fill in all signup fields."
      redirect to '/signup'
    elsif User.find_by(username: params[:username]) != nil
      flash[:taken_username] = "Sorry, that username is already taken."
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
      redirect '/lineups'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/lineups'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/lineups"
    else
      flash[:credentials] = "Sorry, those credentials don't match our records."
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      flash[:outlog] = "You have been logged out."
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
