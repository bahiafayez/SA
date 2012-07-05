# encoding: utf-8

require "net/http"
require "uri"
require "rails"
require "active_record"
require "open-uri"


class Akhbarak < ActiveRecord::Base

	#attr_reader :url_search
  def initialize()
    @url_search='http://www.akhbarak.net/api_v2/advanced_search/body'# /page/2/per_page/100.xml'
    @url_search2='http://www.akhbarak.net/api_v2/articles/search/'#%D8%A7%D8%B3%D8%AF/page/2/per_page/1000.json'
    @map_tweets={}
    @kid=""
    @stopped=0
    @hashtag=""
    @page=1
    @list=[]
    @listids=[]
    @lock = Mutex.new 
  end

  def getArticles(kid, hash_tag) #, num_pages #this id to say start from which (since_id...)
    @kid=kid
    @hashtag=hash_tag
    
    if !Article.where(:source_id => 2, :target_id => @kid).empty?
      @maxid=Article.where(:source_id => 2, :target_id => @kid).first.id_str  # the last id from last time.
    else
      @maxid=0
    end
    
   
      url= "#{@url_search2}#{hash_tag}/page/#{@page}/per_page/100.json"
   
   
    #pp Article.first
  	#max_id=''
  	i=1
  	while getArticles2(url) do
  		print i, ' - ', url
  		
  		@page = @page + 1
  		print "-----------------------------next_page issss #{@page}"
  		#if next_page == ''
  		#	url= ''
  		#else
  		url = "#{@url_search2}/#{hash_tag}/page/#{@page}/per_page/100.json"
  		
  		#end
  		i=i+1
  		
  		if i==10
  		  break
  		end	
  	end
  	#before returning save the tweets
  	
  	#return [max_id, @stopped]
  	analyzeArticles()
  end
  
  def analyzeArticles()  #Not Threaded
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
    
    if !resp.nil? and !resp.empty? and resp.kind_of?(Array) and resp.length==@listids[0,100].length
      
      @listids[0,100].zip(resp).each do |l, a|
        @article=Article.find(l)
        @article.polarity=a[1]
        @article.coloured_text=a[0]
        @article.save
      end
    end
    #puts "resp wwasssss : #{resp}"
    #if !resp.nil? and resp.kind_of?(Array)
    #  puts "size of resppp is #{resp.length}"
    #end
    @list=@list[100..@list.length]
    @listids=@listids[100..@listids.length]
    if !@listids.nil?
      puts "id is #{@listids[0]}"
    end
    end
  end
  
  def getArticles2(url)
	resp=roundGetResponse(url)
	#print "other response ISSS"
	#print resp
	puts "-------------------------------------------"
	#resp = ActiveSupport::JSON.decode resp
	i=1
	
	
	results=resp
	results.each do |r|
	  print '-------------------------'
	  puts "r is #{r}"
	  puts ''
	  #pp r['article']['description']
	  #pp r['article']['published_at']
	  #pp r['article']['id']
	  #pp r['article']['url']
	  #pp r['article']['title']
	  #end
	  
	  #get maximum id
	  
	  if "#{r['article']['id']}"== @maxid
	    finished=true
	    return false   #reached what I got before
	  end
	  
	  if !r['article']['description'].nil?
	   mapTweets( r['article']['description'], r['article']['published_at'], r['article']['id'], r['article']['url'], r['article']['title'])
	  end
	end
	
	if results.nil? or results.empty?
	  return false
	else
	  return true
	end
	

  end
  
  
  def mapTweets(description, date, id, url, title)
    
    uri = URI.parse("http://omp.sameh.webfactional.com/tagging")
      #print "uri is #{uri}"
		s=Source.find_by_name("Articles")  # for now
		
		if Article.where(:id_str=>id, :target_id => @kid, :source_id =>s.id).empty?
		
		@words2=['ا.','د.','م.']    #remove these because these don't represent the end of a sentence.
    @words2.each do |a|
      description.gsub!(a,'')
    end
		  
		sentences=description.split('.')       # defining new sentences with . is that enough?? or also ' ? also dr. won't work..
		print "sentences areeeeeeeeeeee \n #{sentences}"
		@words=Target.find(@kid).query.gsub /"/, ''
		@words=@words.split("OR")
		@words.each(&:lstrip!)
		@words.each(&:rstrip!)

		print @words
		sentences.each do |sentence|
       if @words.any? { |x| sentence.force_encoding('UTF-8').include?(x.force_encoding('UTF-8')) } #if any of the search terms are in the sentence
         puts "yes it includedssss"
        tries=0
    		
    		  begin
    		    #until gateway problem is solved
      		  #conn = Net::HTTP.post_form(uri, "text"=> description )
            #resp= conn.body
            #resp = ActiveSupport::JSON.decode(resp)
      		  #a= Article.create(:id_str => id, :body => description, :source_id=> s.id, :date=> date, :target_id => @kid, :polarity => resp[2], :coloured_text => resp[0])
      		  a= Article.create(:id_str => id, :body => sentence, :source_id=> s.id, :date=> date, :target_id => @kid, :url => url, :title => title)
      		  @list<< sentence
            @listids<<a.id
      		rescue Exception => e  
            tries += 1
            puts "Error: #{e.message}"
            puts "Trying again!" if tries <= 10
            retry if tries <= 10
            puts "No more attempt!"
      		end
		     end
		    #map_tweets[k.to_i] = [v2,v]
	     end
	   end
	#return map_tweets
  end
  
  def roundGetResponse(url)

		tries=0
    begin
     
      #print "url is #{req_url}"
      uri = URI.parse(url)
      #print "uri is #{uri}"
      #conn = Net::HTTP.post_form(uri, params )
      conn = Net::HTTP.get_response(uri)
      resp= conn.body
      #print "response is #{resp}"
      resp = ActiveSupport::JSON.decode(resp)
      #content = resp['responseContent']
      #if !content.includes? "Please retry your request"
      # break
      #end
      #print "Retry Request"
    rescue Exception => e  
      #puts e.message  
      #puts e.backtrace.inspect
      
      tries += 1
      puts "Error: #{e.message}"
      puts "Trying again!" if tries <= 10
      retry if tries <= 10
      puts "No more attempt!"

      #puts "Try again"
      #sleep(10)
      #roundGetResponse(url)
    end
	#end
	return resp
  end
end
