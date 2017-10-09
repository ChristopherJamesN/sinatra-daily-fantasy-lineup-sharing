class LineupsController < ApplicationController

  get '/lineups' do
    if session[:user_id] == nil
      redirect to '/login'
    end
    @lineups = Lineup.all
    erb :'lineups/lineups'
  end

  get '/lineups/new' do
    if session[:user_id] == nil
      redirect to '/login'
    end
    erb :'lineups/create_lineup'
  end

  post '/lineups' do
    if params[:name] == ''
      flash[:lineup_name_empty] = "Your lineup must have a name."
      redirect to 'lineups/new'
    end
    @lineup = Lineup.create(user_id: session[:user_id], name: params[:name], quarterback: params[:quarterback], runningback_one: params[:runningback_one], runningback_two: params[:runningback_two], widereceiver_one: params[:widereceiver_one], widereceiver_two: params[:widereceiver_two], widereceiver_three: params[:widereceiver_three], tightend: params[:tightend], flex: params[:flex], defense: params[:defense])
    flash[:lineup_created] = "Your lineup has been created."
    redirect to "users/#{current_user.id}"
  end

  get '/lineups/:id' do
    if session[:user_id] == nil
      redirect to '/login'
    end
    @lineup = Lineup.find(params[:id])
    erb :'lineups/show_lineup'
  end

  get '/lineups/:id/edit' do
    if session[:user_id] == nil
      redirect to '/login'
    end
    @lineup = Lineup.find(params[:id])
    if session[:user_id] != @lineup.user_id
      redirect to '/lineups'
    end
    erb :'lineups/edit_lineup'
  end

  post '/lineups/:id' do
    @lineup = Lineup.find(params[:id])
    if params[:name] == ''
      flash[:lineup_name_at_update] = "Your lineup must have a name."
      redirect to "lineups/#{@lineup.id}/edit"
    end
    @lineup.update(name: params[:name], quarterback: params[:quarterback], runningback_one: params[:runningback_one], runningback_two: params[:runningback_two], widereceiver_one: params[:widereceiver_one], widereceiver_two: params[:widereceiver_two], widereceiver_three: params[:widereceiver_three], tightend: params[:tightend], flex: params[:flex], defense: params[:defense])
    flash[:lineup_updated] = "Your lineup has been updated."
    redirect to "users/#{current_user.id}"
  end

  delete '/lineups/:id/delete' do
    @lineup = Lineup.find(params[:id])
    if session[:user_id] != @lineup.user_id
      redirect to '/lineups'
    end
    @lineup.delete
    flash[:lineup_deleted] = "Your lineup has been deleted."
    redirect to "users/#{current_user.id}"
  end
end
