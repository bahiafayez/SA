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
    #self.date << " UTC" 
    self.date.strftime('%d %B, %Y %H:%M')
  end
  
  def hour
    self.date.strftime('%d %B, %Y %H:00')
  end
  
  def day
    self.date.strftime('%d %B, %Y')
  end
  
  def self.getComments2()
    Target.all.each do |t|
      getComments(t.id)
    end
  end
  
  def self.getMissingTweets()
    p=MissingTweets.new()
    p.getTweets() 
    
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
  
  def self.getAll(id)
    getAkhbar(id)
    getTweets(id)
  end
  
  def self.getComments(id)
    keyword=Target.find(id.to_i)
    source= Source.find_by_name("Articles")
    day_before = 1.days.ago 
    two_days_before = 2.days.ago
    checkdate= two_days_before.utc.to_formatted_s(:db)
    checkdate2=day_before.utc.to_formatted_s(:db)
    
    #@articles=Article.find(:all, :select => ["distinct(url), id, id_str, source_id, target_id, date"], :conditions =>["source_id = ? and target_id=? and date BETWEEN ? AND ? ", source.id, id.to_i, checkdate, checkdate2])
    @articles=Article.find(:all, :conditions =>["source_id = ? and target_id=? and date BETWEEN ? AND ? ", source.id, id.to_i, checkdate, checkdate2], :group => ['id_str'])#.count  # to get unique id_str only
    @articles.each do |a|
      #@idstr= a.id_str
      if a.url.include?("youm7.com")
        puts "yes in youm7"
         if Comment.find_by_article_id(a.id).nil?  #get comments, if i didn't get comments for this article before (could change later)
           b= URI.parse(a.url)
           newsid=(Rack::Utils.parse_nested_query b.query)["NewsID"]  #to extract the newsid from the url
           y=Youm7comments.new(a.id)
           y.getComments(newsid)
         else
           break #since ordered descendingly, when find an existing id, then break, all rest will be repeated.
         end
      elsif a.url.include?("shorouknews.com")
        puts "yes in shorouk"
        if Comment.find_by_article_id(a.id).nil?  #get comments, if i didn't get comments for this article before (could change later)
           # b= URI.parse(a.url)
           # newsid=(Rack::Utils.parse_nested_query b.query)["NewsID"]  #to extract the newsid from the url
            y=Shorouk.new(a.id)
            y.getComments2(a.url)
         else
           break #since ordered descendingly, when find an existing id, then break, all rest will be repeated.
         end
      elsif a.url.include?("www.ahram.org.eg")
        puts "yes in ahram"
        if Comment.find_by_article_id(a.id).nil?  #get comments, if i didn't get comments for this article before (could change later)
            b= URI.parse(a.url)
            newsid=(Rack::Utils.parse_nested_query b.query)["ContentID"]  #to extract the newsid from the url
            y=Ahramcomments.new(a.id)
            y.getComments(newsid)
         else
           break #since ordered descendingly, when find an existing id, then break, all rest will be repeated.
         end
      else
        puts "can't get comments.. yet"
      end
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
    #sleep(3600)
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
