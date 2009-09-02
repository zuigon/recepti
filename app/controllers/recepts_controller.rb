class ReceptsController < ApplicationController

layout 'application'

  # GET /recepts
  # GET /recepts.xml
  def index
    per_page = 5
    # @recepts = Recept.all
    if params[:kat_id] and params[:kat_id] != "ostale"
      # @recepts = Recept.paginate( :all, :order => "naziv ASC",
      #  :conditions => [ "category_id = ?", params[:kat_id] ],
      #  :per_page => per_page, :page => params[:page] )
      
      # @category = Category.find(params[:kat_id])
      @recepts  = Recept.paginate( :all,
       # :order => "name ASC",
       # :conditions => [ "category_id = ?", params[:kat_id] ],
       :include => 'category',
       :conditions => [ 'categories.id = ?', params[:kat_id] ],
       :per_page => per_page, :page => params[:page] )
      
    elsif params[:kat_id] == "ostali"
      # @recepts = Recept.paginate( :all, :order => "naziv ASC",
      #   :conditions => [ "category_id = NULL" ],
      #   :per_page => per_page, :page => params[:page] )

      @recepts  = Recept.paginate( :all,
       # :order => "name ASC",
       # :conditions => [ "category_id = ?", params[:kat_id] ],
       :include => 'category',
       :conditions => 'categories.id = NULL',
       :per_page => per_page, :page => params[:page] )
    else
      # @recepts = Recept.paginate( :all, :order => "naziv ASC",
      #   :per_page => per_page, :page => params[:page] )
      @recepts = Recept.paginate( :all, :order => "naziv ASC",
        :per_page => per_page, :page => params[:page] )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recepts }
      format.js
    end
  end

  # GET /recepts/1
  # GET /recepts/1.xml
  def show
    @recept = Recept.find(params[:id])
    # @category = (@recept.category_id) ? Category.find(@recept.category_id) : nil
    @categories = begin
                    (@recept.categories_recepts.collect { |cat| Category.find(cat.category_id).name } ).join(", ")
                    # @categories.each{ |cat| cat.name }).join(", ") : "<i>Nema</i>"
                  rescue Exception => e; "<i>Nema</i> #{e}"; end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recept }
    end
  end

  # GET /recepts/new
  # GET /recepts/new.xml
  def new
    @recept = Recept.new
    @recept_template = File.open(RAILS_ROOT + "/app/views/shared/_recept_template.erb").readlines.join("")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recept }
    end
  end

  # GET /recepts/1/edit
  def edit

    @recept = Recept.find(params[:id])
    # if params[:ajax] == '1'
    #   render :layout => "layoutname"
    # end
    
    respond_to do |format|
      format.html
      format.js do
        # render :update do |page|
        #   page.replace_html :flash_notice, flash[:notice]
        #   page.replace_html dom_id(@recept), :partial => "ajax_form", :layout => ""
        #   flash.discard
        # end
        render :partial => "ajax_form", :layout => ""
      end
    end

  end

  # POST /recepts
  # POST /recepts.xml
  def create
    @recept = Recept.new(params[:recept])

    respond_to do |format|
      if @recept.save
        flash[:notice] = 'Recept was successfully created.'
        format.html { redirect_to(@recept) }
        format.xml  { render :xml => @recept, :status => :created, :location => @recept }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recepts/1
  # PUT /recepts/1.xml
  def update
    @recept = Recept.find(params[:id])

    respond_to do |format|
      if @recept.update_attributes(params[:recept])
        flash[:notice] = 'Recept je promijenjen.'
        format.html {
          # if params['recept[ajax]'] == '1'
            # render :update do |page|
            #   ## page.replace_html :flash_notice, flash[:notice]
            #   # page.insert_html :after, '#container h1', flash[:notice]
            #   page.replace_html 'edit_recept_'+@recept.id, :partial => "recept", :layout => ""
            #   flash.discard
            #   page << "alert('Poruka iz _update_ ! !')"
            # end
          # else
            redirect_to(@recept)
          # end
          # render :partial => "recept", :layout => ""
        }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recept.errors, :status => :unprocessable_entity }
        format.js   { }
      end
    end
  end

  # DELETE /recepts/1
  # DELETE /recepts/1.xml
  def destroy
    @recept = Recept.find(params[:id])
    @recept_dom_id = dom_id(@recept)
    @recept.destroy

    respond_to do |format|
      format.html { redirect_to(recepts_url) }
      format.xml  { head :ok }
      format.js
    end
  end

end
