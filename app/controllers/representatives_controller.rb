class RepresentativesController < ApplicationController
  def show
    @representative = Representative.find(params[:id])
    @rep_votes = RepVotes.where(rep_name: "#{@representative.name}")
    @categories = Category.all.sort_by(&:name)
    if params[:category]
      category = Category.find_by_name(params[:category])
      @bills = Bill.where(category_id: category.id)
    else
      @bills = Bill.all
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Sorry! That link doesn't exist. Try again!"
    redirect_to '/'
  end
end
