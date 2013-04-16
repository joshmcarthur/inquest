class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.all

    render
  end

  def show
    @tag = Tag.find(params[:id])

    render
  end
end
