class UsersController < ApplicationController

  get '/users/:id' do
    authenticate_user
    @user = User.find(params[:id])
    if @user && @user == current_user
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
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect '/lineups'
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect to '/signup'
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
