class LineupsController < ApplicationController

  get '/lineups' do
    authenticate_user
    @lineups = Lineup.all
    erb :'lineups/lineups'
  end

  get '/lineups/new' do
    authenticate_user
    erb :'lineups/create_lineup'
  end

  post '/lineups' do
    authenticate_user
    @lineup = current_user.lineups.build(name: params[:name], quarterback: params[:quarterback], runningback_one: params[:runningback_one], runningback_two: params[:runningback_two], widereceiver_one: params[:widereceiver_one], widereceiver_two: params[:widereceiver_two], widereceiver_three: params[:widereceiver_three], tightend: params[:tightend], flex: params[:flex], defense: params[:defense])
    #create a nested hash here to reduce line length
    if @lineup.save
      flash[:lineup_created] = "Your lineup has been created."
      redirect to "/users/#{current_user.id}"
    else
      flash[:error] = @lineup.errors.full_messages.join(', ')
      redirect to "/lineups/new"
    end
  end

  get '/lineups/:id' do
    authenticate_user
    @lineup = Lineup.find(params[:id])
    erb :'lineups/show_lineup'
  end

  get '/lineups/:id/edit' do
    authenticate_user
    @lineup = Lineup.find(params[:id])
    if session[:user_id] != @lineup.user_id
      redirect to '/lineups'
    end
    erb :'lineups/edit_lineup'
  end

  post '/lineups/:id' do
    authenticate_user
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
    authenticate_user
    @lineup = Lineup.find(params[:id])
    if session[:user_id] != @lineup.user_id
      redirect to '/lineups'
    end
    @lineup.delete
    flash[:lineup_deleted] = "Your lineup has been deleted."
    redirect to "users/#{current_user.id}"
  end
end
