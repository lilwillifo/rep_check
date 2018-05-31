class RepresentativesController < ApplicationController
  def show
    @representative = Representative.new(params[:id])
    @rep_votes = RepVotes.where(rep_name: "#{@representative.name}")
    @categories = Category.all
    if params[:category]
      category = Category.find_by_name(params[:category])
      @bills = Bill.where(category_id: category.id)
    else
      @bills = Bill.all
    end
  end
end
