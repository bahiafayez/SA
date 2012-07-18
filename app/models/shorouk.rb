#encoding: utf-8

require "net/http"
require "uri"
require "open-uri"
require "rails"
require "pp"


class Shorouk < ActiveRecord::Base
#################################### Youm7 comments #########################################

def initialize(aid)
  @aid=aid
end


def html_getter(url)
	

	tries=0
    begin
     
      uri = URI.parse(url)
      conn = Net::HTTP.get_response(uri)
      resp= conn.body
      #resp = ActiveSupport::JSON.decode(resp)
     
    rescue Exception => e  
      
      tries += 1
      puts "Error: #{e.message}"
      puts "Trying again!" if tries <= 10
      retry if tries <= 10
      puts "No more attempt!"
	end
	
	return resp

end



def getComments2(newsPageLink)
	 html = html_getter(newsPageLink)
	 contentId = newsPageLink[newsPageLink.rindex('id=')+3 .. newsPageLink.length-1]
	 # use () to capture things in regex
	 puts "contentid is #{contentId}"
	 pattern_num_comments = /div class="innerComments" .*>[\s]+[^0-9]*([\d]+)[\s]+<i/
	 num_comment =  pattern_num_comments.match(html)
	 puts "here before"
	 #p num_comment.string
	 #p num_comment.pre_match

	 #puts "num_comment is #{num_comment}"
	 if !num_comment.nil? and num_comment.length>1
		num_comment=num_comment[1].to_i
	 else
		num_comment=0
	 end
	 
	 puts "num_comment is #{num_comment}"
	 
	 comments = []
	 if num_comment > 0
		start =0
		while start < num_comment do
			raw_comments = getComments(contentId, start)
			raw_comments.each do |c|
				c= c['Body']
				comments << c
			end
			start += 10
		end
	 end
	 
	 #return comments
	 puts "There are #{comments.length} comments found in Shorouk"
	 analyzeComments(comments)
end

def analyzeComments(comments)  #Not Threaded
    uri = URI.parse("http://omp.sameh.webfactional.com/taggingList")
    #uri = URI.parse("http://names.alwaysdata.net/taggingList")
    comments2=comments
    while !comments2.nil? and !comments2.empty? do
    tries=0
    to_tag_json = ActiveSupport::JSON.encode(comments2[0,100])
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
    
    puts "resp size isss #{resp.length}"
    puts "cmomments size isss #{comments2[0,100]}"
    
    if !resp.nil? and !resp.empty? and resp.kind_of?(Array) and resp.length==comments2[0,100].length
      puts "over hereeeee"
      comments2[0,100].zip(resp).each do |l, a|
        @c= Comment.create(:article_id =>@aid , :comment => l, :coloured_comment => a[0], :polarity => a[1])
      end
    end
    #puts "resp wwasssss : #{resp}"
    #if !resp.nil? and resp.kind_of?(Array)
    #  puts "size of resppp is #{resp.length}"
    #end
    comments2=comments2[100..comments2.length]
    
    end
  end



def getComments(contentId, start)
puts "in getComments"
comments=[]
comment_URL = "http://www.shorouknews.com/_Services/ContentCommentService.asmx/GetComments"
params = {'start'=> start,'commentsCount'=>'10','contentId'=> contentId,'orderDescending'=>'True','contentType'=>'News','commentOrderBy'=>'Latest'}
#Content type matters!!
tries=0

uri = URI.parse(comment_URL)
	begin
		#uri.query= URI.encode_www_form(params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout=3600
      http.open_timeout=3600
      request = Net::HTTP::Post.new(uri.request_uri)
	  
	  request.add_field("User-Agent" , "Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.8.1.14) Gecko/20080609 Firefox/2.0.0.14")
	  request.add_field("Accept" , "application/json, text/javascript, */*; q=0.01")
	  request.add_field("Accept-Language" , "en-us,en;q=0.5")
	  request.add_field("Accept-Charset" , "ISO-8859-1,utf-8;q=0.7,*;q=0.7")
	  request.add_field("Content-type" , "application/json; charset=utf-8")
	  request.add_field("Host", "www.shorouknews.com")

	  request.body=ActiveSupport::JSON.encode(params)
	  
	  response= http.request(request)
      resp=response.body
	 
	  #puts "resp is!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	  #puts resp
      resp = ActiveSupport::JSON.decode(resp)
    rescue Exception => e  
        tries += 1
        puts "Error: #{e.message}"
        puts "Trying again analyze!" if tries <= 3
        retry if tries <= 3
        puts "No more attempts in analyzing!"  
    end

  return resp["d"]
#return comments
end


#comments=getComments2("http://www.shorouknews.com/complaints/view.aspx?cdate=28062012&id=8553d7a4-72a9-40c9-8c42-a7c4c857e0e0")
end
#puts "Comments are #{comments.length}"
#comments.each do |c|
#	puts c
#end


