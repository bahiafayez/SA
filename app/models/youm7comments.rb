# encoding: utf-8

require "net/http"
require "uri"
require "open-uri"
require "rails"
require "pp"
#require 'rubygems'
#require "nokogiri"


class Youm7comments < ActiveRecord::Base
#################################### Youm7 comments #########################################

def initialize(aid)
  @aid=aid
end

def html_getter2(url)
	open(url) do |f|
  # hash with meta information
  pp  f.meta

  #
  pp "Content-Type: " + f.content_type
  pp "last modified" + f.last_modified.to_s

  no = 1
  # print the first three lines
  f.each do |line|
    print "#{no}: #{line}"
    no += 1
    break if no > 4
  end
end
end

def html_getter(url)
	

	tries=0
    begin
	
	#uri = URI.parse(url)
	#result = Net::HTTP.start(uri.host, uri.port) {|http|
#		http.get(uri.request_uri)
#	}
  puts "got hereeeee"
     
      uri = URI.parse(url)
      conn = Net::HTTP.get_response(uri)
	  @response=conn
	 puts conn['content-type']
      resp= conn.body.force_encoding('windows-1256')
	  puts resp.encoding
	  puts "resp isssssss"
	  #print conn
      #resp = ActiveSupport::JSON.decode(resp)
	#p result['content-type']     # "text/xml; charset=UTF-8" <- correct
	#p result.content_type        # "text/xml" <- incorrect; truncates the charset field
	#puts result.body.encoding
	 
    rescue Exception => e  
      
      tries += 1
      puts "Error: #{e.message}"
      puts "Trying again!" if tries <= 10
      retry if tries <= 10
      puts "No more attempt!"
	end
	
	
	
	
	document=Nokogiri::HTML(resp.encode('utf-8'),nil, 'utf-8')
	return "#{document}"

end




def getComments(newsID)
  puts "OVER HEREEEEEEEEEEEEEEEEEEEEEEEE"
	pattern_comment = '<div class="commentBody">[^\^]*?<\/div>'
	comments = []
	page_num = 1
	comment_URL = "http://www.youm7.com/Includes/NewsComments.asp?page=#{page_num}&NewsID=#{newsID}"
	while comment_URL != '' do
		comment_html = html_getter(comment_URL)
		#puts comment_html
		raw_comments=comment_html.scan(/#{pattern_comment}/)       
		raw_comments.each do |c|
			c = c[c.index("<p>")+3 .. c.index("</p>")-1]
			while c.include?('<br>')
				c['<br>']= '\n'
			end
			c.force_encoding('UTF-8')
			comments << c
        end
		        
		if !comment_html.index("page=#{page_num+1}&amp;NewsID=#{newsID}").nil?
			page_num += 1
			comment_URL = "http://www.youm7.com/Includes/NewsComments.asp?page=#{page_num}&NewsID=#{newsID}"
		else
			comment_URL = ""
		end
    end
  
  puts "There are #{comments.length} comments found in Youm7"
  analyzeComments(comments)
	#return comments
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

#comments=getComments(732869)
#puts "Comments are #{comments.length}"
#comments.each do |c|
#	puts c
#	puts ""
#end

end