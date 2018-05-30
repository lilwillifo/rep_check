class RepresentativesController < ApplicationController
  def show
    @representative = Representative.new(params[:id])
    @rep_votes = RepVotes.where(rep_name: "#{@representative.name}")
    @bills = Bill.all
  end
end
