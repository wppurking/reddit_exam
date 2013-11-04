require 'spec_helper'

describe Reddit do
  describe '搜索 reddit.com 网站' do
    let(:form) { RedditForm.new(search: '') }
    let(:form_with_word) { RedditForm.new(search: 'rails') }

    context '搜索 Form 的返回路径' do
      it '应该返回首页路径' do
        expect(form.url).to eq('http://www.reddit.com')
      end

      it '应该返回带有关键词的搜索路径' do
        expect(form_with_word.url).to eq('http://www.reddit.com/search?q=rails')
      end
    end

    context '解析 Reddit 网站访问的结果' do
      before do
        resp = double("resp")
        file = open('./spec/htmls/reddit.html').read
        allow(resp).to receive(:body).and_return(file)
        allow(resp).to receive(:code).and_return(200)
        allow(Reddit).to receive(:get).and_return(resp)
      end

      context '拥有关键字的' do
        it '应该拥有 25 个结果' do
          expect(Reddit.new.reddits(form_with_word)[:body].size).to eq(25)
        end

        it '成功解析一个 Reddit' do
          hash = Reddit.new.reddits(form_with_word)
          reddit = hash[:body][0]
          expect(reddit[:title]).to include('drawings, and diagrams.')
          expect(reddit[:url]).to eq('http://imgur.com/a/uCSg1')
          expect(reddit[:score]).to eq('3427')
          expect(hash[:next_page]).to eq('http://www.reddit.com/?count=25&after=t3_1pudgz')
        end
      end
    end

  end
end
