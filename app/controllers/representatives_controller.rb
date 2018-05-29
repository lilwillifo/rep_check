class RepresentativesController < ApplicationController
  def show
    @representative = Representative.new(params[:id])
  end
end
