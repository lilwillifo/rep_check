class FavoritesController < ApplicationController
  before_action :require_login

  def create
    favorite = Favorite.create(representative_id: params[:representative_id], user_id: current_user.id)
    flash[:success] = 'Added to your favorite list!'
    redirect_to representative_path(favorite.representative)
  end

  def index
    @representatives = current_user.representatives
  end
end
