class Manage::EntriesController < ApplicationController

  
  def invoice
    

    @entry = Entry.find(params[:id])    
    
    @entry.invoice_date = Time.now
   if @entry.save
        redirect_to manage_entries_path
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
  end


  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all

    if params.has_key? :widget
      show_layout = false
    else
      show_layout = true
    end
    
    respond_to do |format|
      format.html  { render :layout => show_layout }
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    
    @entry = Entry.new(params[:entry])
    @entry.date = Date.strptime(params[:entry][:date], '%m/%d/%Y')
    
    respond_to do |format|
      if @entry.save
        format.html { redirect_to manage_entry_path( @entry ), notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])
    
    unless  params[:entry][:date].nil?
    params[:entry][:date] = Date.strptime(params[:entry][:date], '%m/%d/%Y')
    end

    unless  params[:entry][:invoice_date].nil?
      puts "date submitted"
      params[:entry][:invoice_date] = Date.strptime(params[:entry][:invoice_date], '%m/%d/%Y')
      
    end



    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to manage_entry_path(@entry), notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to manage_entries_path }
      format.json { head :no_content }
    end
  end
end
