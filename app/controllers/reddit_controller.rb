class RedditController < ApplicationController

  def index
    @form = RedditForm.new
  end

  def search
    form = RedditForm.new reddit_form_params
    @result = Reddit.new.reddits(form)
  end

  private
  def reddit_form_params
    params.require(:reddit_form).permit(:search)
  end
end
