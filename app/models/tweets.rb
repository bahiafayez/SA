require "net/http"
require "uri"
require "rails"
require "active_record"

class Tweets < ActiveRecord::Base

	#attr_reader :url_search
  def initialize()
    @url_search='http://search.twitter.com/search.json'
    @map_tweets={}
  end

  def getTweets(hash_tag, id, num_pages) #this id to say start from which (since_id...)
    url= "#{@url_search}?q=#{hash_tag}&rpp=100&since_id=#{id}"
    pp Article.first
	max_id=''
	i=1
	while i<num_pages and url != '' do
		print i, ' - ', url
		mp, max_id, next_page= getTweets2(url)
		if next_page == ''
			url= ''
		else
			url = "#{@url_search}#{next_page}"
		end
		i=i+1
	end
	return max_id
  end
  
  def getTweets2(url)
	resp=roundGetResponse(url)
	#print "other response ISSS"
	print resp
	puts "-------------------------------------------"
	#resp = ActiveSupport::JSON.decode resp
	i=1
	while resp.has_key?("error") and (resp['error'] == 'Invalid query' or resp['error'] == 'You have been rate limited. Enhance your calm.') do
		print "Try #{i}, Err: #{resp['error']} " 
		i=i+1
		resp = roundGetResponse(url)
		#resp = ActiveSupport::JSON.decode resp
	end
	
	if resp.has_key?("results")
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
	end
  end
  
  
  def MapTweets(results)
    map_tweets={}
	results.each do |r|
		k= r['id_str']
		v= r['text']
		v2= r['created_at']
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
		end
	#end
	return resp
  end
end
