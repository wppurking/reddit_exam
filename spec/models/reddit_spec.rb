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
      def init_reddit_resp(uri)
        resp = double("resp")
        file = open(uri).read
        allow(resp).to receive(:body).and_return(file)
        allow(resp).to receive(:code).and_return(200)
        allow(Reddit).to receive(:get).and_return(resp)
      end

      it '应该拥有 25 个结果' do
        expect(Reddit.new.reddits(form_with_word)[:body].size).to eq(25)
      end

      it '成功解析一个 Reddit, 有翻页' do
        init_reddit_resp('./spec/htmls/reddit.html')
        hash = Reddit.new.reddits(form_with_word)
        reddit = hash[:body][0]
        expect(reddit[:title]).to include('My coworker is a')
        expect(reddit[:url]).to eq('http://memedad.com/memes/56357.jpg')
        expect(reddit[:score]).to eq('2613')
        expect(hash[:next_page]).to eq('count=50&after=t3_1pwgde')
        expect(hash[:prev_page]).to eq('count=26&before=t3_1pwa6v')
      end

      it '成功解析一个 Reddit, 首页前一页' do
        init_reddit_resp('./spec/htmls/reddit_home.html')
        hash = Reddit.new.reddits(form_with_word)
        reddit = hash[:body][0]
        expect(reddit[:title]).to include('(x-post from r/stlouis)')
        expect(reddit[:url]).to eq('http://i.imgur.com/UTBxFIt.png')
        expect(reddit[:score]).to eq('3140')
        expect(hash[:next_page]).to eq('count=25&after=t3_1pvo5s')
        expect(hash[:prev_page]).to eq('')
      end

      it '成功解析一个 Reddit, 搜索页面' do
        init_reddit_resp('./spec/htmls/reddit_search.html')
        hash = Reddit.new.reddits(form_with_word)
        reddit = hash[:body][0]
        expect(reddit[:title]).to include('I have ever created (Java)')
        expect(reddit[:url]).to eq('http://www.reddit.com/r/learnprogramming/comments/176iwa/i_give_you_the_best_200_assignments_i_have_ever/')
        expect(reddit[:score]).to eq('1047')
        expect(hash[:next_page]).to eq('q=java&count=50&after=t3_rt092')
        expect(hash[:prev_page]).to eq('q=java&count=26&before=t3_176iwa')
      end
    end

  end
end
