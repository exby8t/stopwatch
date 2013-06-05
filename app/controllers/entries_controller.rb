class EntriesController < ApplicationController

  before_filter :require_login
  
  
  layout 'widget', :except => [:index]
  layout 'xby8'
  # GET /entries
  # GET /entries.json
 

def submit
    @invoice = Invoice.find(params[:id])
    @invoice.sent_date = Time.now
    
     respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice(@invoice), notice: 'Invoice was processed.' }
        format.json { render json: @invoice}
      else
        format.html { render action: "current" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def unsubmit
    @invoice = Invoice.find(params[:id])
    @invoice.sent_date = nil
    @invoice.save


  end

  def current
    @invoice = Invoice.current(session[:user][:id], params[:project_id])
    @entries = @invoice.entries
  end

  def addEntry

    @entry = Entry.find(params[:entry_id])
    @invoice = Invoice.current(session[:user][:id], @entry.project_id)

    @invoice.entries << @entry

    @result = {
          :action => "added", 
          :invoice_id => @invoice.id, 
          :project_id => @entry.project.id, 
          :count => @invoice.entries.count 
        }

        render json: @result
=begin
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end

=end    
  end

  def removeEntry
    @entry = Entry.find(params[:entry_id])
    @invoice = Invoice.current(session[:user][:id], @entry.project_id)

    @entry.invoice_id = nil
    @entry.save
        @resultData = {
          :action => "added", 
          :invoice_id => @invoice.id, 
          :project_id => @entry.project.id, 
          :count => @invoice.entries.count 
        }

        render json: @resultData
=begin
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result }
    end

=end 
  end



  def index
    @entries = Entry.open

    respond_to do |format|
      format.html  #{ render :layout => show_layout }
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


end
