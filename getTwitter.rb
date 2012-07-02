# encoding: utf-8
 
# require 'twitter'
# 
# Twitter.search("مرسي", :rpp => 1000 ).each do |status|
  # p status.id
  # p status.text
  # p status.created_at
  
  #end
  

s="ابو د. م. ا. مبارك سجل عندك. واحد من انصار شفيق"
@words=['ا.','د.','م.']
@words.each do |a|
  s.gsub!(a,'')
end
#s.gsub(, '')
p=s.split('.')
#print p
p.each do |r|
  if r.include?("سجل")
    print "سجل is in #{r}"
    puts ""
  else
    print "سجل is not in #{r}"
    puts ""
  end
end

a=s.match /\w+|\W/u
print a





