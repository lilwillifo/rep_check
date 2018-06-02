class FavoritesController < ApplicationController
  before_action :require_login

  def create
    favorite = Favorite.create(representative_id: params[:representative_id], user_id: current_user.id)
    flash[:success] = 'Added to your favorite list!'
    redirect_to representative_path(favorite.representative)
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    flash[:success] = 'Removed from your favorite list!'
    redirect_to '/'
  end
end
