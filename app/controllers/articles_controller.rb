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
  
  def get_count
    val=params[:val]
    source=params[:src]
    #all={'value'=> val, 'source'=> source}
    
     count=  [
          ['2012-03-15', Random.rand(500),Random.rand(500),Random.rand(500)],
          ['2012-03-16', Random.rand(500),Random.rand(500),Random.rand(500)],
          ['2012-03-17', Random.rand(500),Random.rand(500),Random.rand(500)],
          ['2012-03-18', Random.rand(500),Random.rand(500),Random.rand(500)]
        ]
    render json: count
  end
  
  def get_mentions
    source=params[:src]
    y = Date.new(2012, 3, 15)
    z = Date.new(2012, 3, 16)
    if source=="articles"
      count=[
          [y, 111,22,234,111,33],
          [z, 11,242,34,119,3]
        ]
    elsif source=="comments"
      count= [
          [y, 1,2,3,4,33],
          [z, 11,242,4,119,3]
        ]
    else
      # count= [
          # [y, 55,22,54,111,89],
          # [z, 11,34,34,77,3]
        # ]
        s=Source.find_by_name("Twitter")
        #Article.where(:source_id => s.id)
        #Article.joins(:keywords).where('keywords.name'=> "Morsi").count
        count=[]
        #@a=Article.joins(:keywords).where('articles.source_id'=>s.id, 'keywords.name'=> "Morsi").count(group: :date)
        @a= Article.where(:source_id=>s.id, :target_id=> params[:val])#.count(group: :date)
        gg=0
        @a.group_by(&:hour).sort.each do |hour, posts|
          print "Here"
          gg=gg+posts.count
          print "#{hour} : #{posts.count}"
          count<<[hour,posts.count]
        end
        print "gg issss #{gg}"
        # @a.each do |a|
          # count<< [a[0],0,0,0,0,a[1]]
        # end
    end
    render json: count
 end

  def get_text
    keyword=params[:keyword]
    date=params[:date]
    stat=params[:stat]
    
    
    date2= 1.minutes.since date.to_datetime
    date3=date.to_datetime
    print date2
    print date3
    checkdate= Time.parse(date).to_formatted_s(:db)
    print "over hereeeeee"
    a= 1.minutes.since Time.parse(date)
    checkdate2=a.to_formatted_s(:db)
    # checkdate2= Time.zone.parse(date2).utc.to_formatted_s(:db)
    # print "checkdate issss"
     print checkdate
    # print checkdate
    
    s=Source.find(:first, :conditions => [ "lower(name) = ?", stat.downcase ])
    
        text=[]
        #@a=Article.where(:date > date , :source_id=> s.id, :target_id=> 1)
        #@a =Article.find(:all, :conditions =>["date(date) BETWEEN ? AND ? ", date2, date3])
        @a=Article.find(:all, :conditions =>["date BETWEEN ? AND ? and source_id = ? and target_id=? ", checkdate, checkdate2, s.id, keyword])

        #@a=Article.joins(:keywords).where('articles.source_id'=>s.id, 'keywords.name'=> keyword, 'articles.date'=>checkdate)
        @a.each do |a|
          text<< a.body
        end
    
    render json: text
 end


end

#Assume we want Morsi


