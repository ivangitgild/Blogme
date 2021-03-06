class ArticlesController < ApplicationController

  def index
    @articles = Article.paginate :page => params[:page], :order => 'updated_at DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  #{ render :xml => @articles }
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.xml  { render :xml => @articles }
    end
  end

  def new
    @article = Article.new
    @authors = Author.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @articles }
    end
  end
  
  def edit
    @article = current_author.articles.find(params[:id])
    #@authors = Author.all
  end

  def create
    #@article = Article.new(params[:article])
    #@authors = Author.all
    @article = current_author.articles.build(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    #@article = Article.find(params[:id])
    #@authors = Author.all
    @article = current_author.articles.find(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

end
