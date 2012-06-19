# encoding: utf-8
 
require 'twitter'

Twitter.search("مرسي", :rpp => 1000 ).each do |status|
  p status.id
  p status.text
  p status.created_at
  
end