require "./app/models/tweets"
require "net/http"
require "uri"
require "pp"
#require 'config/environment'


# New Twitter object
p=Tweets.new


print p.instance_variables # to get instance variables.
print p.instance_variable_get("@url_search") # this is no accessor
#print p.url_search # use this if have accessor for url_search

#a= p.getTweets("morsi", 215206877615755264, 3)
#print 'haha\n'
#print a  # this a will be used in the since_id field.
#a= Net::HTTP.post_form(URI.parse("http://www.google.com"), {'q'=>'bahia'})
#print a.body

#since_id is the max_id of last time.

#pp p.instance_variable_get("@map_tweets")
#print Article.all
