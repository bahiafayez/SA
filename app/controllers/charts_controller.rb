class ChartsController < ApplicationController
  def index
  end
  
  def sentiment
    
  end
  
  def allcharts
    
  end
  
  def check
    @val=params[:keywords]
    @src=""
    
    params.each do |p|
      if p[1]=="Detailed View"
        print "hereeee key isss #{p[0]}"
        @both=p[0].split("_")
        @src=@both[0]
        @type=@both[1]
      end
    end
    
    if @type=="mentions"
      redirect_to charts_mentions_path(:val=>@val, :src => @src)
    else
      redirect_to charts_sentiments_path(:val=>@val, :src => @src) 
    end
    
  end
  
  def mentions
    @val=params[:val]
    @src=params[:src]
    
    # params.each do |p|
      # if p[1]=="Detailed View"
        # print "hereeee key isss #{p[0]}"
        # @both=p[0].split("_")
        # @src=@both[0]
        # @type=@both[1]
      # end
    # end
    
    @target=Target.find(@val)
    @target=@target.name
    print "in mentions"
    print @val
    print @src
  end
  
  def sentiments
    @val=params[:val]
    @src=params[:src]
    @target=Target.find(@val)
    @target=@target.name
    print "in sentiments"
    print @val
    print @src
    render "sentiments"  
  end
  
end
