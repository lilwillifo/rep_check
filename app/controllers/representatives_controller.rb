class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find_by(district: params[:id])
    @rep_votes = RepVotes.where(rep_name: "#{@representative.name}")
    @categories = Category.all.sort_by(&:name)
    @bills = bills
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Sorry! That link doesn't exist. Try again!"
    redirect_to '/'
  end

  def update
    fav = Favorite.find_by(representative_id: params[:id], user_id: current_user.id)
    fav.destroy
    flash[:success] = 'Removed from your watch list!'
    redirect_to '/'
  end

  def create
    redirect_to "/representatives/#{address.district}"
  end

  def index
    @representatives = Representative.all
  end

  private
  def address
    GeocodioService.new( { street: params['street'],
                           city: params['city'],
                           state: params['state'],
                           postal_code: params['postal_code']
                        })
  end

  def bills
    if params[:category]
      category = Category.find_by_name(params[:category])
      @bills = Bill.where(category_id: category.id)
    else
      @bills = Bill.all
    end
  end
end
