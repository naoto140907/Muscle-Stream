class TweetsController < ApplicationController
    before_action :authenticate_user!
    def index
      @tweets = Tweet.all
            #部分検索かつ複数検索
      search = params[:search]

      if params[:tag]
        Tag.create(name: params[:tag])
      end

    #以下を追記

    
  @tags = Tag.all
  @tweets = Tweet.joins(:user).where("body LIKE ? OR menu LIKE ? OR diet LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") if search.present?
  #もしタグ検索したら、post_idsにタグを持ったidをまとめてそのidで検索
  if params[:tag_ids].present?
    post_ids = []
    params[:tag_ids].each do |key, value| 
      if value == "1"
        Tag.find_by(name: key).tweets.each do |p| 
          post_ids << p.id
        end
      end
    end
    post_ids = post_ids.uniq
    #キーワードとタグのAND検索
    @tweets = @tweets.where(id: post_ids) if post_ids.present?
  end

    @tweets = @tweets.page(params[:page]).per(3)
  end

    def new
        @tweet = Tweet.new
    end

    def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id

        if tweet.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
        @tweet = Tweet.find(params[:id])

        @comments = @tweet.comments
        @comment = Comment.new
    end

    def edit
        @tweet = Tweet.find(params[:id])
    end

    def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
          redirect_to :action => "show", :id => tweet.id
        else
          redirect_to :action => "new"
        end
      end
    
      def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
      end

    private
    def tweet_params
        params.require(:tweet).permit(:body,:menu,:diet, :photo, tag_ids: [])
    end
end
