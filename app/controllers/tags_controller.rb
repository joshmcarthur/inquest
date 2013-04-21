class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.all

    render
  end

  def show
    @tag = Tag.find(params[:id])
    return if redirect_empty_tag

    render
  end

  private

  # Public: Prevent a tag from displaying if there are no questions tagged with it.
  #
  # Requires @tag be set
  #
  # Returns true if the current action should abort, or false if not
  def redirect_empty_tag
    redirect_to(
      Tag,
      notice: "There are no questions tagged with this tag, please select another to view."
    ) if @tag.questions.count.zero?
  end
end
