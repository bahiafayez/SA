class Article < ActiveRecord::Base

  default_scope :order => 'id_str DESC'

  belongs_to :source
  has_many :comments, :dependent => :destroy, :order => "id ASC"
  
  has_many :article_keywords
  has_many :keywords, :through => :article_keywords, :dependent => :destroy
  
  
  def self.getTweets(keyword_id)
    keyword=Keyword.find(keyword_id)
    synonyms= Synonym.where(:keyword_id => keyword_id)
    search=[]
    synonyms.each do |s|
      search<<"\"#{s.name}\""
    end
    search=search.join(" OR ")
    search=URI::encode(search)
    pp search
    #search= keyword.name  #later get synonyms
    
    
    max_id= keyword.max_id_twitter
  	p=Tweets.new()
  	a, stop= p.getTweets(keyword_id,search, max_id, -1) #removed numpages for now.
  	print a 
  	keyword.max_id_twitter= a
  	keyword.save
  	
  	print "Stopped is #{stop}"
  	
  	#maxid won't change as im going backwards
  	while stop.to_i > max_id.to_i do
    	p=Tweets.new()
      a, stop= p.getTweets(keyword_id,search, max_id , stop) #removed numpages for now. £old max_id.. 0
      print a 
    end
    
    #Still max is 1500!
  end
end
