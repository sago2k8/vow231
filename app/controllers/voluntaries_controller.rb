 
 
class VoluntariesController < ApplicationController
  before_action :set_voluntary, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @voluntaries = Voluntary.all
  end 

  def show
  end 

  def new 
    @voluntary = Voluntary.new
  end 

  def edit
  end 

  def create
    @voluntary = Voluntary.new(voluntary_params)
    @voluntary.save
    respond_with(@voluntary)
  end 

  def update
    @voluntary.update(voluntary_params)
    flash[:notice] = 'Voluntary was successfully updated.'
    respond_with(@voluntary)
  end 

  def destroy
    @voluntary.destroy
    redirect_to voluntaries_url, notice: 'Voluntary was successfully destroyed.'
  end 

  private
    def set_voluntary
      @voluntary = Voluntary.find(params[:id])
    end 

    def voluntary_params
      params.require(:voluntary).permit(:user_id, :name, :photo_url) 
    end 
end
 
