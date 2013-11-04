# 实验一次在 rails 中使用 Form Object
class RedditForm
  include ActiveModel::Model

  attr_accessor :search

  def url
    if search.blank?
      'http://www.reddit.com'
    else
      "http://www.reddit.com/search?q=#{search}"
    end
  end
end