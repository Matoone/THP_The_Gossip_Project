class CitiesController < ApplicationController
  def show
    @id = params[:id]
    @city = City.find(params[:id])
  end
end
