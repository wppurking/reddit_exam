module ApplicationHelper
  def active(path)
    'active' if controller_path == path
  end

  def reddit_link
    link_to('reddit.com', 'http://reddit.com', target: '_blank')
  end
end
