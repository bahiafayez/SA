class ArticleKeyword < ActiveRecord::Base

  belongs_to :article
  belongs_to :keyword
  
end
