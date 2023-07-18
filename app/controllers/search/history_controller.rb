class Search::HistoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @history = Search.where(user: current_user).pluck("term")
  end
end
