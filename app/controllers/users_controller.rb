class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      session[:user_id] = @user.id
      session[:username] = @user.username
      respond_to do |format|
        format.js
      end
    else
      render "new"
    end
  end
  
  def show
    @user = User.find_by_username(params[:username])
    @personal_top_games = @user.games.order('final_score').reverse[0..9]
  end
end
