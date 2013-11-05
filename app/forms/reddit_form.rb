# 实验一次在 rails 中使用 Form Object
class RedditForm
  include ActiveModel::Model

  attr_accessor :search, :count, :after, :before, :q

  def url
    if search.blank?
      'http://www.reddit.com'
    else
      "http://www.reddit.com/search?q=#{URI.encode(search)}"
    end
  end

  def pager_url
    if q.blank?
      "http://www.reddit.com/?count=#{count}&after=#{after}"
    elsif not after.blank?
      "http://www.reddit.com/search?q=#{URI.encode(q)}&count=#{count}&after=#{after}"
    elsif not before.blank?
      "http://www.reddit.com/search?q=#{URI.encode(q)}&count=#{count}&before=#{before}"
    else
      "http://www.reddit.com/search?q=#{URI.encode(q)}&count=#{count}"
    end
  end
end