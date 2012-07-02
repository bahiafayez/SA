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
    @map_tweets={}
    @kid=""
    @stopped=0
    @hashtag=""
  end

  def getArticles(kid, hash_tag) #, num_pages #this id to say start from which (since_id...)
    @kid=kid
    @hashtag=hash_tag
   
      url= "#{@url_search}/#{hash_tag}/from/2/per_page/10"
   
   
    #pp Article.first
  	#max_id=''
  	i=1
  	#while url != '' and i<20 do 
  		print i, ' - ', url
  		getArticles2(url)
  		#print "-----------------------------next_page issss #{next_page}"
  		#if next_page == ''
  		#	url= ''
  		#else
  		#	url = "#{@url_search}#{next_page}"
  		#end
  		i=i+1
  	#end
  	#before returning save the tweets
  	
  	#return [max_id, @stopped]
  end
  
  def getArticles2(url)
	resp=roundGetResponse(url)
	#print "other response ISSS"
	#print resp
	puts "-------------------------------------------"
	#resp = ActiveSupport::JSON.decode resp
	i=1
	
	
	results=resp[1]
	results.each do |r|
	  print '-------------------------'
	  puts ''
	  pp r['article']['description']
	  pp r['article']['published_at']
	  pp r['article']['id']
	  pp r['article']['url']
	  pp r['article']['title']
	  #end
	  mapTweets( r['article']['description'], r['article']['published_at'], r['article']['id'], r['article']['url'], r['article']['title'])
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
