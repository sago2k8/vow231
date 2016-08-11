 
 
class FoundationsController < ApplicationController
  before_action :set_foundation, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @foundations = Foundation.all
  end 

  def show
  end 

  def new 
    @foundation = Foundation.new
  end 

  def edit
  end 

  def create
    @foundation = Foundation.new(foundation_params)
    @foundation.save
    respond_with(@foundation)
  end 

  def update
    @foundation.update(foundation_params)
    flash[:notice] = 'Foundation was successfully updated.'
    respond_with(@foundation)
  end 

  def destroy
    @foundation.destroy
    redirect_to foundations_url, notice: 'Foundation was successfully destroyed.'
  end 

  private
    def set_foundation
      @foundation = Foundation.find(params[:id])
    end 

    def foundation_params
      params.require(:foundation).permit(:user_id, :name, :photo_url, :description) 
    end 
end
 
