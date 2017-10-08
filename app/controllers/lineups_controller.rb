class LineupsController < ApplicationController

  get '/lineups' do
    if session[:id] == nil
      redirect to '/login'
    end
    @lineups = Lineup.all
    erb :'lineups/lineups'
  end

  get '/lineups/new' do
    if session[:id] == nil
      redirect to '/login'
    end
    erb :'lineups/create_lineup'
  end

  post '/lineups' do
    if params[:name] == ''
      redirect to 'lineups/new'
    end
    @lineup = Lineup.create(name: params[:name], user_id: session[:id])
    @user = User.find(@lineup.user_id)
    @user.lineups << @lineup
  end

  get '/lineups/:id' do
    if session[:id] == nil
      redirect to '/login'
    end
    @lineup = Lineup.find(params[:id])
    erb :'lineups/show_lineup'
  end

  get '/lineups/:id/edit' do
    if session[:id] == nil
      redirect to '/login'
    end
    @lineup = Lineup.find(params[:id])
    if session[:id] != @lineup.user_id
      redirect to '/lineups'
    end
    erb :'lineups/edit_lineup'
  end

  post '/lineups/:id' do
    @lineup = Lineup.find(params[:id])
    if params[:name] == ''
      redirect to "lineups/#{@lineup.id}/edit"
    end
    @lineup.update(name: params[:name])
  end

  delete '/lineups/:id/delete' do
    @lineup = Lineup.find(params[:id])
    if session[:id] != @lineup.user_id
      redirect to '/lineups'
    end
    @lineup.delete
    redirect to '/lineups'
  end
end
