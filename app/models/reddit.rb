class Reddit < ActiveRecord::Base
  include HTTParty
  headers 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36',
          'Accept-Encoding' => 'gzip'

  def reddits(form)
    reddits_get(form.url)
  end

  def reddits_pager(form)
    reddits_get(form.pager_url)
  end

  def reddits_get(url)
    resp = self.class.get(url)
    if resp.code == 200
      doc = Nokogiri::HTML.parse(resp.body)
      links = doc.css('#siteTable .thing').map do |thing|
        body = {}
        body[:title] = thing.at_css('a.title').text
        body[:score] = thing.at_css('.unvoted .unvoted').text
        url = thing.at_css('a.title')['href']
        body[:url] = if url.first == '/'
                       'http://www.reddit.com' << url
                     else
                       url
                     end
        body
      end
      {
          body: links,
          next_page: pager_url(doc, '.nav-buttons .nextprev a[rel~=next]'),
          prev_page: pager_url(doc, '.nav-buttons .nextprev a[rel~=prev]')
      }
    else
      {body: %w(链接有错误), next_page: '#'}
    end
  end

  def pager_url(doc, selector)
    link = doc.at_css(selector)
    if link
      link['href'].split('?')[1]
    else
      ''
    end
  end


end
