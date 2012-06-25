require "net/http"
require "uri"
require "rails"
require "active_record"
require "open-uri"

class Article < ActiveRecord::Base

  default_scope :order => 'id_str DESC'

  belongs_to :source
  has_many :comments, :dependent => :destroy, :order => "id ASC"
  
  belongs_to :target
  
  def minute
    self.date.strftime('%d %B, %Y %H:%M')
  end
  
  def hour
    self.date.strftime('%d %B, %Y %H:00')
  end
  
  def day
    self.date.strftime('%d %B, %Y')
  end
  
  def self.getAkhbar2()
    Target.all.each do |t|
      getAkhbar(t.id)
    end
  end
  
  def self.getTweets2()
    Target.all.each do |t|
      getTweets(t.id)
    end
  end
  
  def self.getTweets(keyword_id)
    keyword=Target.find(keyword_id.to_i)
    print "keyword id issssss"
    puts keyword
    #synonyms= Synonym.where(:keyword_id => keyword_id)
    #search=[]
    #synonyms.each do |s|
    #  search<<"\"#{s.name}\""
    #end
    #search=search.join(" OR ")
    search=URI::encode(keyword.query)
    print search
    #search= keyword.name  #later get synonyms
    
    
    max_id= keyword.max_id_twitter
  	p=Tweets.new()
  	a, stop= p.getTweets(keyword_id,search, max_id, -1) #removed numpages for now.
  	print a 
  	keyword.max_id_twitter= a
  	keyword.save
  	
  	print "Stopped is #{stop}"
  	
  	#maxid won't change as im going backwards
  	# while stop.to_i > max_id.to_i do
    	# p=Tweets.new()
      # a, stop= p.getTweets(keyword_id,search, max_id , stop) #removed numpages for now. £old max_id.. 0
      # print a 
    # end
    
    #Still max is 1500!
    #sleep(1800)
    #getTweets(keyword_id)
  end
  
  def self.getAkhbar(keyword_id)
    keyword=Target.find(keyword_id.to_i)
    print "keyword id issssss"
    puts keyword
    term=keyword.query.sub("OR","" )
    search=URI::encode(term)
    print search
    
    #tosearch= "www.akhbarak.net/api_v2/articles/search/#{search}/page/2/per_page/100.json"
    #tosearch = "http://www.akhbarak.net/api_v2/advanced_search/body/#{search}/from/2/per_page/10"
    
    p=Akhbarak.new()
    p.getArticles(keyword_id, search)
    
    
    # max_id= keyword.max_id_twitter
    # p=Tweets.new()
    # a, stop= p.getTweets(keyword_id,search, max_id, -1) #removed numpages for now.
    # print a 
    # keyword.max_id_twitter= a
    # keyword.save
    
    # print "Stopped is #{stop}"
    
  end
end
