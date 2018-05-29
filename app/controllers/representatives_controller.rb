class RepresentativesController < ApplicationController
  def show
    @representative = Representative.new(params[:id])
    @bills = Bill.all
  end
end
