class PagesController < ApplicationController
  def home
  end
  def calculator
    @result = params[:p].to_i * params[:q].to_i
  end
end
