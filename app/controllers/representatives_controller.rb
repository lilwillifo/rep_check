class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find_by(district: params[:id])
    @categories = Category.all.sort_by(&:name)
    @bills_and_votes = bills_and_votes
  rescue Exception
    flash[:notice] = "Sorry! That link doesn't exist."
    redirect_to '/'
  end

  def update
    fav = Favorite.find_by(representative_id: params[:id], user_id: current_user.id)
    fav.destroy
    flash[:success] = 'Removed from your watch list. 👀'
    redirect_to '/'
  end

  def create
    redirect_to "/representatives/#{address.district}"
  rescue Exception
    flash[:notice] = "Please enter a valid address."
    redirect_to '/'
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
    elsif params[:month]
        @bills = Bill.where(month: params[:month])
    else
      @bills = Bill.all
    end
  end

  def bills_and_votes
    @rep_votes = RepVotes.where(rep_name: "#{@representative.name}")
    bills_and_votes = {}
    bills.each do |bill|
      bills_and_votes[bill] = @rep_votes.find_by(bill_id: bill.id).vote_with
    end
    bills_and_votes
  end
end
