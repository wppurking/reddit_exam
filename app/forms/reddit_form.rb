# 实验一次在 rails 中使用 Form Object
class RedditForm
  include ActiveModel::Model

  attr_accessor :search, :count, :after, :q

  def url
    if search.blank?
      'http://www.reddit.com'
    else
      "http://www.reddit.com/search?q=#{search}"
    end
  end

  def pager_url
    if q.blank?
      "http://www.reddit.com/?count=#{count}&after=#{after}"
    else
      "http://www.reddit.com/search?q=#{q}&count=#{count}&after=#{after}"
    end
  end
end