class Article < ActiveRecord::Base
  belongs_to :source
  has_many :comments, :dependent => :destroy, :order => "id ASC"
  
  
  def self.getTweets()
	p=Tweets.new()
	a= p.getTweets("morsi", 215206877615755264, 3)
	print a 
  end
end
