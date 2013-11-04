class Reddit < ActiveRecord::Base
  include HTTParty
  headers 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.65 Safari/537.36',
          'Accept-Encoding' => 'gzip'

  def reddits(form)
    resp = self.class.get(form.url)
    if resp.code == 200
      doc = Nokogiri::HTML.parse(resp.body)
      links = doc.css('#siteTable .thing').map do |thing|
        body = {}
        body[:title] = thing.at_css('a.title').text
        body[:url] = thing.at_css('a.title')['href']
        body[:score] = thing.at_css('.unvoted .unvoted').text
        body
      end
      {body: links, next_page: doc.at_css('.nav-buttons .nextprev a')['href']}
    else
      {body: %w(链接有错误), next_page: '#'}
    end
  end


end
