class ReceptsController < ApplicationController

layout 'application'

  # GET /recepts
  # GET /recepts.xml
  def index
    # @recepts = Recept.all
    if params[:kat_id].type == "String"
      @recepts = Recept.paginate( :all, :order => "naziv ASC",
       :conditions => [ "category_id IS ?", params[:kat_id] ],
       :per_page => 10, :page => params[:page] )
    elsif params[:kat_id] == "ostale"
      @recepts = Recept.paginate( :all, :order => "naziv ASC",
        :conditions => [ "category_id IS NULL" ],
        :per_page => 10, :page => params[:page] )
    else
      @recepts = Recept.paginate( :all, :order => "naziv ASC",
        :per_page => 10, :page => params[:page] )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recepts }
    end
  end

  # GET /recepts/1
  # GET /recepts/1.xml
  def show
    @recept = Recept.find(params[:id])
    @category = (@recept.category_id) ? Category.find(@recept.category_id) : nil

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recept }
    end
  end

  # GET /recepts/new
  # GET /recepts/new.xml
  def new
    @recept = Recept.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recept }
    end
  end

  # GET /recepts/1/edit
  def edit
    @recept = Recept.find(params[:id])
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
        flash[:notice] = 'Recept was successfully updated.'
        format.html { redirect_to(@recept) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recepts/1
  # DELETE /recepts/1.xml
  def destroy
    @recept = Recept.find(params[:id])
    @recept.destroy

    respond_to do |format|
      format.html { redirect_to(recepts_url) }
      format.xml  { head :ok }
    end
  end
end
