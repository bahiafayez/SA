# encoding: utf-8

require "net/http"
require "uri"
require "rails"
require "active_record"
require "open-uri"

class MissingTweets < ActiveRecord::Base

	#attr_reader :url_search
  def initialize()
    @list=[]
    @listids=[]
    @lock = Mutex.new  # For thread safety .. didn't use it.. no shared variables..
  end

  def getTweets() #, num_pages #this id to say start from which (since_id...)
    
    getMissingTweets()
  	analyzeTweets()
  	
  end
  
  
    def analyzeTweets()  #Not Threaded
    uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    #uri = URI.parse("http://names.alwaysdata.net/taggingList")
    
    while !@list.nil? and !@list.empty? do
    tries=0
    to_tag_json = ActiveSupport::JSON.encode(@list[0,100])
    post_body = to_tag_json
    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout=3600
      http.open_timeout=3600
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = post_body
      response= http.request(request)
      resp=response.body
      resp = ActiveSupport::JSON.decode(resp)
    rescue Exception => e  
        tries += 1
        puts "Error: #{e.message}"
        puts "Trying again analyze!" if tries <= 3
        retry if tries <= 3
        puts "No more attempts in analyzing!"  
    end
    
    puts "resp is #{resp}"
    if !resp.nil? and !resp.empty? and resp.kind_of?(Array) and @listids[0,100].length == resp.length
      @listids[0,100].zip(resp).each do |l, a|
        @article=Article.find(l)
        @article.polarity=a[1]
        @article.coloured_text=a[0]
        @article.save
      end
    end
    @list=@list[100..@list.length]
    @listids=@listids[100..@listids.length]
    if !@listids.nil?
      puts "id is #{@listids[0]}"
    end
    end
  end
  
  # def analyzeTweets2()  #Threaded
#     
    # puts "in here"
    # i=0
    # arr=[]
    # while !@list.nil?
      # print "IN HEREEEEEEE"
      # puts "i isss #{i}"
      # puts @list
      # puts @listids
      # a=@list[0,100]
      # b=@listids[0,100]
      # arr<<Thread.new{analyzeTweets(a, b)}
      # @list=@list[100..@list.length]
      # @listids=@listids[100..@listids.length]
      # i=i+1
      # if arr.length==5
        # arr.each {|t| t.join; }
        # arr=[]
      # end
#       
    # end
    # arr.each {|t| t.join; } #in ruby if dont join mainthread won't wait
#     
  # end
#   
  # def analyzeTweets(analyzed, theids)
    # #uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    # uri = URI.parse("http://names.alwaysdata.net/taggingList")
#     
    # #while !@list.nil? and !@list.empty? do
    # tries=0
    # to_tag_json = ActiveSupport::JSON.encode(analyzed)
    # post_body = to_tag_json
    # begin
      # http = Net::HTTP.new(uri.host, uri.port)
      # http.read_timeout=3600
      # http.open_timeout=3600
      # request = Net::HTTP::Post.new(uri.request_uri)
      # request.body = post_body
      # response= http.request(request)
      # resp=response.body
      # resp = ActiveSupport::JSON.decode(resp)
    # rescue Exception => e  
        # tries += 1
        # puts "Error: #{e.message}"
        # puts "Trying again analyze!" if tries <= 3
        # retry if tries <= 3
        # puts "No more attempts in analyzing!"  
    # end
#     
#     
#    
    # if !resp.nil? and !resp.empty? and resp.kind_of?(Array)        #TRY AGAIN THEN TRY SEQUENTIAL WITH 500 EACH TIME TO MAKE SURE THIS IS BETTER
      # if resp.length != theids.length
        # analyzeTweets(analyzed, theids)
      # else
        # theids.zip(resp).each do |l, a|
          # @lock.synchronize{
          # article=Article.find(l)
          # article.polarity=a[1]
          # article.coloured_text=a[0]
          # article.save
          # }
        # end
      # end
    ## else
       ## analyzeTweets(analyzed, theids)
    # end
#     
    # #if !@listids.nil?
    # #  puts "id is #{@listids[0]}"
    # #end
    # puts "this thread finished."
#     
  # end
  
  
  
 
  def getMissingTweets()
    
    
		s=Source.find_by_name("Twitter")
		
		Article.where(:source_id => s.id, :polarity=> nil).each do |d|
		  
  		  
		    @list<<d.body
		    @listids<<d.id
		 
  	end

  end
  
  

end
