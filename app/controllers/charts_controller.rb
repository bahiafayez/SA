class ChartsController < ApplicationController
  def index
  end
  
  def sentiment
    
  end
  
  def allcharts
    
  end
  
  def mentions
    @val=params[:keywords]
    @src=params[:src]
    @target=Target.find(@val)
    @target=@target.name
    print "in mentions"
    print @val
    print @src
  end
end
