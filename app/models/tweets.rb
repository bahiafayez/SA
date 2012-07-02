# encoding: utf-8

require "net/http"
require "uri"
require "rails"
require "active_record"
require "open-uri"

class Tweets < ActiveRecord::Base

	#attr_reader :url_search
  def initialize()
    @url_search='http://search.twitter.com/search.json'
    @map_tweets={}
    @kid=""
    @stopped=0
    @list=[]
    @listids=[]
    @lock = Mutex.new  # For thread safety .. didn't use it.. no shared variables..
  end

  def getTweets(kid, hash_tag, id ,stop) #, num_pages #this id to say start from which (since_id...)
    @kid=kid
    #hash_tag=URI::encode("\"#{hash_tag}\"") # to search for exact phrase
    print "hashtag is #{hash_tag}"
    if stop== -1
      url= "#{@url_search}?q=#{hash_tag}&rpp=100&since_id=#{id}"
    else
      url= "#{@url_search}?q=#{hash_tag}&rpp=100&since_id=#{id}&max_id=#{stop}"
    end
    
    #pp Article.first
  	max_id=''
  	i=1
  	next_page="abc"
  	while next_page != '' and i<17 do 
  		print i, ' - ', url
  		mp, max_id, next_page= getTweets2(url)
  		print "-----------------------------next_page issss #{next_page}"
  		if next_page == ''
  			url= ''
  		else
  			url = "#{@url_search}#{next_page}"
  		end
  		i=i+1
  	end
  	#before returning save the tweets
  	analyzeTweets2()
  	#Now will analyze them!
  
  	return [max_id, @stopped]
  end
  def analyzeTweets2()  #Threaded
    
    puts "in here"
    i=0
    arr=[]
    while !@list.nil?
      print "IN HEREEEEEEE"
      puts "i isss #{i}"
      puts @list
      puts @listids
      a=@list[0,100]
      b=@listids[0,100]
      arr<<Thread.new{analyzeTweets(a, b)}
      @list=@list[100..@list.length]
      @listids=@listids[100..@listids.length]
      i=i+1
      if arr.length==5
        arr.each {|t| t.join; }
        arr=[]
      end
      
    end
    arr.each {|t| t.join; } #in ruby if dont join mainthread won't wait
    
  end
  
  def analyzeTweets(analyzed, theids)
    #uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    uri = URI.parse("http://names.alwaysdata.net/taggingList")
    
    #while !@list.nil? and !@list.empty? do
    tries=0
    to_tag_json = ActiveSupport::JSON.encode(analyzed)
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
        puts "Trying again analyze!" if tries <= 10
        retry if tries <= 10
        puts "No more attempts in analyzing!"  
    end
    
    
   
    if !resp.nil? and !resp.empty?         #TRY AGAIN THEN TRY SEQUENTIAL WITH 500 EACH TIME TO MAKE SURE THIS IS BETTER
      if resp.length != theids.length
        analyzeTweets(analyzed, theids)
      else
        theids.zip(resp).each do |l, a|
          @lock.synchronize{
          article=Article.find(l)
          article.polarity=a[1]
          article.coloured_text=a[0]
          article.save
          }
        end
      end
    else
       analyzeTweets(analyzed, theids)
    end
    
    #if !@listids.nil?
    #  puts "id is #{@listids[0]}"
    #end
    puts "this thread finished."
    
  end
  
  
  
  # def analyzeTweets()  #Not Threaded
    # #uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    # uri = URI.parse("http://names.alwaysdata.net/taggingList")
#     
    # while !@list.nil? and !@list.empty? do
    # tries=0
    # to_tag_json = ActiveSupport::JSON.encode(@list[0,100])
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
        # puts "Trying again analyze!" if tries <= 10
        # retry if tries <= 10
        # puts "No more attempts in analyzing!"  
    # end
#     
    # if !resp.nil? and !resp.empty?
#       
      # @listids[0,100].zip(resp).each do |l, a|
        # @article=Article.find(l)
        # @article.polarity=a[1]
        # @article.coloured_text=a[0]
        # @article.save
      # end
    # end
    # @list=@list[100..@list.length]
    # @listids=@listids[100..@listids.length]
    # if !@listids.nil?
      # puts "id is #{@listids[0]}"
    # end
    # end
  # end
  
  def getTweets2(url)
	resp=roundGetResponse(url)
	#print "other response ISSS"
	#print resp
	puts "-------------------------------------------"
	#resp = ActiveSupport::JSON.decode resp
	i=1
	#make sure its working..
	if !resp.nil? and !resp.empty? # or put in loop? kda because might now be any data in the last hour.. wala ehCHECK!!
	while (resp.has_key?("error") and (resp['error'] == 'Invalid query' or resp['error'] == 'You have been rate limited. Enhance your calm.')) do
		print "Try #{i}, Err: #{resp['error']} " 
		sleep(5)
		i=i+1
		resp = roundGetResponse(url)
		#resp = ActiveSupport::JSON.decode resp
	end
	end
	
	if !resp.nil? and resp.has_key?("results")
		results=resp['results']
		max_id= resp['max_id_str']
		next_page=''
		if resp.has_key?('next_page')
			next_page = resp['next_page']
		end
		@map_tweets=MapTweets(results)
		return [@map_tweets, max_id, next_page]
	else
		print "Error #{resp}"
		#return [0,0,0]
	end
  end
  
  
  def MapTweets(results)
    
    uri = URI.parse("http://omp.sameh.webfactional.com/tagging")
      #print "uri is #{uri}"
    
    map_tweets={}
	  results.each do |r|
		k= r['id_str']
		@stopped=k
		v= r['text']
		v2= r['created_at']
		# Store here directly
		s=Source.find_by_name("Twitter")
		tries=0
		
    
		if Article.where(:id_str=>k, :target_id => @kid, :source_id => s.id).empty?
		  #begin
  		  #conn = Net::HTTP.post_form(uri, "text"=> v )
        #resp= conn.body
        #resp = ActiveSupport::JSON.decode(resp)
  		  a= Article.create(:id_str => k, :body => v, :source_id=> s.id, :date=> v2, :target_id => @kid)#, :polarity => resp[2], :coloured_text => resp[0])
		    @list<<v
		    @listids<<a.id
		  #rescue Exception => e  
        #tries += 1
        #puts "Error: #{e.message}"
        #puts "Trying again!" if tries <= 10
        #retry if tries <= 10
        #puts "No more attempts!"
  		#end
  	end
		
		map_tweets[k.to_i] = [v2,v]
	end
	return map_tweets
  end
  
  def roundGetResponse(url)
	params={		"format" => "json",
					"apiProvider" => "twitter",
                    "attachmentFormat"=> "mime",
                    "attachmentParamName"=>"",    
                    "attachmentType"=>    "local",
                    "authTestType"=>    "noAuth",
                    #"clientIpValue"=>   "10.203.10.109",
                    "headers_name_0"=>"",    
                    "headers_value_0"=>"",    
                    "httpMethod"=>    "get",
                    "parameters_name_0"=>"q",    
                    "parameters_value_0"=>"morsi",    
                    "publicMethodTest"=> "true",
                    "requestBody"=> "",    
                    "urlToTest"=>    @url_search,
                    "url_authentication_select"=>    "noAuth",
                    "url_verb_select"=>    "get"
                    }
	#params.map{|key,value|"#{key}=#{value}"}.join("&")						
	req_url= 'https://apigee.com/console/-1/testApi'	
	#while true do
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
			#	break
			#end
			#print "Retry Request"
		rescue Exception => e  
			#puts e.message  
			#puts e.backtrace.inspect
			
			tries += 1
      puts "Error: #{e.message}"
      puts "Trying again!" if tries <= 3
      retry if tries <= 3
      puts "No more attempts!"
      
      
			#puts "Try again"
			#sleep(10)
			#roundGetResponse(url)
		end
	#end
	return resp
  end
end
