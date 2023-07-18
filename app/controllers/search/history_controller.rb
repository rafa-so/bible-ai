class Search::HistoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @history = Search.where(user: current_user).select("id", "term")
  end

  def show
    @response = Search.find(history_params[:id])
  end

  private

  def history_params
    params.permit(:id)
  end
end
