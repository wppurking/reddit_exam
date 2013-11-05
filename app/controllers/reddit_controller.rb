class RedditController < ApplicationController

  def index
    @form = RedditForm.new
  end

  def search
    form = RedditForm.new reddit_form_params
    @result = Reddit.new.reddits(form)
  end

  def pager
    form = RedditForm.new reddit_pager_params
    @result = Reddit.new.reddits_pager(form)
    render :search
  end

  private
  def reddit_form_params
    params.require(:reddit_form).permit(:search)
  end

  def reddit_pager_params
    params.permit(:count, :after, :q)
  end
end
