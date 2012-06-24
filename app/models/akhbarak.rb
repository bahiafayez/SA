# encoding: utf-8

require "net/http"
require "uri"
require "rails"
require "active_record"
require "open-uri"

class Akhbarak < ActiveRecord::Base

	#attr_reader :url_search
  def initialize()
    @url_search='http://www.akhbarak.net/api_v2/articles/search/'# /page/2/per_page/100.xml'
    @map_tweets={}
    @kid=""
    @stopped=0
  end

  def getArticles(kid, hash_tag, id ,stop) #, num_pages #this id to say start from which (since_id...)
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
  	while url != '' and i<20 do 
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
  	
  	return [max_id, @stopped]
  end
  
  def getTweets2(url)
	resp=roundGetResponse(url)
	#print "other response ISSS"
	#print resp
	puts "-------------------------------------------"
	#resp = ActiveSupport::JSON.decode resp
	i=1
	while resp.has_key?("error") and (resp['error'] == 'Invalid query' or resp['error'] == 'You have been rate limited. Enhance your calm.') do
		print "Try #{i}, Err: #{resp['error']} " 
		sleep(5)
		i=i+1
		resp = roundGetResponse(url)
		#resp = ActiveSupport::JSON.decode resp
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
		
		
    
		if Article.where(:id_str=>k, :target_id => @kid).empty?
		  conn = Net::HTTP.post_form(uri, "text"=> v )
      resp= conn.body
      resp = ActiveSupport::JSON.decode(resp)
		  a= Article.create(:id_str => k, :body => v, :source_id=> s.id, :date=> v2, :target_id => @kid, :polarity => resp[2], :coloured_text => resp[0])
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
			puts e.message  
			puts e.backtrace.inspect
			#puts "Try again"
			#sleep(10)
			#roundGetResponse(url)
		end
	#end
	return resp
  end
end
