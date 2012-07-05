class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end
  
  def getSelected
    @status=params[:val]
    session[:status]=params[:val]
    render json: @status
  end
  
  def get_count
    val=params[:val]
    source=params[:src]
    #all={'value'=> val, 'source'=> source}
    
    s=Source.find(:first, :conditions => [ "lower(name) = ?", source.downcase ])
        #Article.where(:source_id => s.id)
        #Article.joins(:keywords).where('keywords.name'=> "Morsi").count
        count=[]
        #@a=Article.joins(:keywords).where('articles.source_id'=>s.id, 'keywords.name'=> "Morsi").count(group: :date)
        @a= Article.where(:source_id=>s.id, :target_id=> params[:val])#.count(group: :date)
        #@positive=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity > 0", s.id, keyword])
        #@neutral=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity = 0", s.id, keyword])
        #@negative=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity < 0", s.id, keyword])
        gg=0
        prevHour=""
        if params[:stat]=="per day"
          @a.group_by(&:day).sort{|x,y| Time.parse(x[0]) <=> Time.parse(y[0])}.each do |hour, posts|
          print "Here"
          gg=gg+posts.count
          print "#{hour} : #{posts.count}"
          next_day=1.days.since Time.parse(hour)
          
          checkdate= Time.parse(hour).to_formatted_s(:db)
          checkdate2=next_day.to_formatted_s(:db)
          
          checkdate0= Time.parse(hour)
          checkdate3=next_day
          
          # Filling in zeros
          if prevHour.kind_of?(Time)
               diff=checkdate0-prevHour
               diff2= diff/86400  #to get days
               fromDate=prevHour
               nextHour=fromDate
                 while diff2> 0 
                   count<<[nextHour.strftime('%d %B, %Y'), 0,0,0]
                   nextHour= 1.day.since fromDate
                   diff2-=1 
                   fromDate=nextHour
                 end
            end
          
          @positive=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity > 0 and date BETWEEN ? AND ? ", s.id, val, checkdate, checkdate2])
          @neutral=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity = 0 and date BETWEEN ? AND ? ", s.id, val, checkdate, checkdate2])
          @negative=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity < 0 and date BETWEEN ? AND ? ", s.id, val, checkdate,  checkdate2])
          
          count<<[hour,@negative.count, @neutral.count, @positive.count]
          prevHour=checkdate3
          end
        else
          lastDate=@a.first.date
          @a.group_by(&:hour).sort{|x,y| Time.parse(x[0]) <=> Time.parse(y[0])}.each do |hour, posts|
          print "Here"
          gg=gg+posts.count
          print "#{hour} : #{posts.count}"
          next_hour=1.hours.since Time.parse(hour)
          
          checkdate0= Time.parse(hour).utc
          checkdate= Time.parse(hour).utc.to_s  #needed to add utc because search is in utc!? for some reason.. even though config is local time..
          checkdate2=next_hour.utc.to_s       #needed to add utc because search is in utc!? for some reason.. even though config is local time..
          checkdate3=next_hour.utc
          
          puts "date difference issssss#{lastDate - checkdate0}"
          if lastDate - checkdate0  > 86400
            next
          end
          
          # Filling in zeros
          if prevHour.kind_of?(Time)
               diff=checkdate0-prevHour
               diff2= diff/3600  #to get hours
               fromDate=prevHour
               nextHour=fromDate
                 while diff2> 0 
                   count<<[nextHour.strftime('%d %B, %Y %H:00'), 0,0,0]
                   nextHour= 1.hour.since fromDate
                   diff2-=1 
                   fromDate=nextHour
                 end
            end
            
          puts "checkdate isss #{checkdate}"
          puts "checkdate2 isss #{checkdate2}"
          
          @positive=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity > 0 and date BETWEEN ? AND ? ", s.id, val, checkdate, checkdate2])
          @neutral=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity = 0 and date BETWEEN ? AND ? ", s.id, val, checkdate, checkdate2])
          @negative=Article.find(:all, :conditions =>["source_id = ? and target_id=? and polarity < 0 and date BETWEEN ? AND ? ", s.id, val, checkdate,  checkdate2])
          
          count<<[hour, @negative.count, @neutral.count,@positive.count]
          prevHour=checkdate3
          end
        end
    
     # count=  [
          # ['2012-03-15', Random.rand(500),Random.rand(500),Random.rand(500)],
          # ['2012-03-16', Random.rand(500),Random.rand(500),Random.rand(500)],
          # ['2012-03-17', Random.rand(500),Random.rand(500),Random.rand(500)],
          # ['2012-03-18', Random.rand(500),Random.rand(500),Random.rand(500)]
        # ]
    render json: count
  end
  
  def get_mentions
    source=params[:src]
    y = Date.new(2012, 3, 15)
    z = Date.new(2012, 3, 16)
    if source=="articles"
      s=Source.find_by_name("Articles")
    elsif source=="comments"
      s=Source.find_by_name("Comments")

    else
      # count= [
          # [y, 55,22,54,111,89],
          # [z, 11,34,34,77,3]
        # ]
        s=Source.find_by_name("Twitter")
    end
        #Article.where(:source_id => s.id)
        #Article.joins(:keywords).where('keywords.name'=> "Morsi").count
        count=[]
        #@a=Article.joins(:keywords).where('articles.source_id'=>s.id, 'keywords.name'=> "Morsi").count(group: :date)
        @a= Article.where(:source_id=>s.id, :target_id=> params[:val])#.count(group: :date)
        gg=0
        prevHour=""
        if params[:stat]=="per hour"
          @a.group_by(&:hour).sort{|x,y| Time.parse(x[0]) <=> Time.parse(y[0])}.each do |hour, posts|
            #puts "hour isss #{Time.parse(hour)}" 
            # FILLING IN ZEROS WHERE THERE ARE NO MENTIONS
            if prevHour.kind_of?(Time)
               diff=Time.parse(hour)-prevHour
               diff2= diff/3600  #to get hours
               fromDate=prevHour
                 while diff2> 1 
                   nextHour= 1.hour.since fromDate
                   nextHour2= nextHour.strftime('%H:00')
                   count<<[nextHour2,0, "#{nextHour.strftime('%d %B, %Y %H:00')}\n Mentions: 0"]
                   diff2-=1 
                   fromDate=nextHour
                 end
            end
            print "Here"
            gg=gg+posts.count
            print "#{hour} : #{posts.count}"
            only=Time.parse(hour)
            only=only.strftime('%H:00')
            count<<[only,posts.count, "#{hour}\n Mentions: #{posts.count}"]
            prevHour=Time.parse(hour)
          end
        elsif params[:stat]=="per day"
          @a.group_by(&:day).sort{|x,y| Time.parse(x[0]) <=> Time.parse(y[0])}.each do |hour, posts|
          if prevHour.kind_of?(Time)
               diff=Time.parse(hour)-prevHour
               diff2= diff/86400  #to get days
               fromDate=prevHour
                 while diff2> 1 
                   nextHour= 1.day.since fromDate
                   #nextHour2= nextHour.strftime('%H:00')
                   count<<[nextHour.strftime('%d %B, %Y'),0, "#{nextHour.strftime('%d %B, %Y')}\n Mentions: 0"]
                   diff2-=1 
                   fromDate=nextHour
                 end
            end  
          print "Here"
          gg=gg+posts.count
          print "#{hour} : #{posts.count}"
          count<<[hour,posts.count, "#{hour}\n Mentions: #{posts.count}"]
          prevHour=Time.parse(hour)
          end
        else
          @a.group_by(&:hour).sort{|x,y| Time.parse(x[0]) <=> Time.parse(y[0])}.each do |hour, posts|
          #zone = ActiveSupport::TimeZone.new("Cairo")
          #puts "hour isss #{Time.parse(hour)}"
          if prevHour.kind_of?(Time)
               diff=Time.parse(hour)-prevHour
               diff2= diff/3600  #to get hours
               fromDate=prevHour
                 while diff2> 1 
                   nextHour= 1.hour.since fromDate
                   nextHour2= nextHour.strftime('%H:00')
                   count<<[nextHour2,0, "#{nextHour.strftime('%d %B, %Y %H:00')}\n Mentions: 0"]
                   diff2-=1 
                   fromDate=nextHour
                 end
            end  
          print "Here"
          gg=gg+posts.count
          print "#{hour} : #{posts.count}"
          only=Time.parse(hour)
          only=only.strftime('%H:00')
          count<<[only,posts.count, "#{hour}\n Mentions: #{posts.count}"]
          prevHour=Time.parse(hour)
          end
        end
        
        
        print "gg issss #{gg}"
        # @a.each do |a|
          # count<< [a[0],0,0,0,0,a[1]]
        # end
    
    render json: count
 end

  def get_text
    keyword=params[:keyword]
    date=params[:date]
    stat=params[:stat]
    type=params[:charttype]
    
    if type=="per day"
      a= 1.days.since Time.parse(date)
    else
      a= 1.hours.since Time.parse(date)
    end
     date2= 1.minutes.since date.to_datetime
    date3=date.to_datetime
    print date2
    print date3
    checkdate= Time.parse(date).utc.to_formatted_s(:db)
    print "over hereeeeee"
    #a= 1.minutes.since Time.parse(date)
    checkdate2=a.utc.to_formatted_s(:db)
    # checkdate2= Time.zone.parse(date2).utc.to_formatted_s(:db)
    # print "checkdate issss"
     print checkdate
    # print checkdate
    
    s=Source.find(:first, :conditions => [ "lower(name) = ?", stat.downcase ])
    
        text=[]
        #@a=Article.where(:date > date , :source_id=> s.id, :target_id=> 1)
        #@a =Article.find(:all, :conditions =>["date(date) BETWEEN ? AND ? ", date2, date3])
        if params[:sent]=="Positive"
          @a=Article.find(:all, :conditions =>["date BETWEEN ? AND ? and source_id = ? and target_id=? and polarity>0", checkdate, checkdate2, s.id, keyword])
        elsif params[:sent]=="Neutral"
          @a=Article.find(:all, :conditions =>["date BETWEEN ? AND ? and source_id = ? and target_id=? and polarity=0", checkdate, checkdate2, s.id, keyword])
        elsif params[:sent]=="Negative"
          @a=Article.find(:all, :conditions =>["date BETWEEN ? AND ? and source_id = ? and target_id=? and polarity<0", checkdate, checkdate2, s.id, keyword])
        else
          @a=Article.find(:all, :conditions =>["date BETWEEN ? AND ? and source_id = ? and target_id=? ", checkdate, checkdate2, s.id, keyword])
        end
        

        #@a=Article.joins(:keywords).where('articles.source_id'=>s.id, 'keywords.name'=> keyword, 'articles.date'=>checkdate)
        if params[:sent]
          @a.each do |l|
            text<< l.coloured_text
          end
        else
          @a.each do |l|
            text<< l.body
          end
        end
    
    render json: text
 end


end

#Assume we want Morsi


