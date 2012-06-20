ActiveAdmin.register Article do
  
  action_item only:[:index] do
    link_to "Get Tweets ", "/admin/articles/get_tweets"
  end
  
  collection_action :get_tweets do
  end
  
  collection_action :get_tweets2, :method => :post do
    keyword=params[:keyword]
    Article.getTweets(keyword.to_i)
    redirect_to admin_articles_path
  end
  
end
