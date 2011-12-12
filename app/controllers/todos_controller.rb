class TodosController < ApplicationController
  # GET /todos
  # GET /todos.xml
  def index
    @todos = Todo.where(:done => false).select {|todo| todo.is_current? }
    @todos.sort!

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end
  
  def all
    @todos = Todo.all # where(:done => false)
    @todos.sort!
    params[:notice] = "Showing complete todo list."
    
    respond_to do |format|
      format.html { render :index }
      format.xml  { render :xml => @todos }
    end
  end
  
  def tickler
    @todos = Todo.where(:done => false).select { |todo| todo.due_at.nil? }
    @todos.sort!
    params[:notice] = "Showing only todos items without a due date."
    
    respond_to do |format|
      format.html { render :index }
      format.xml  { render :xml => @todos }
    end
  end
  
  def markdone
    params["todos"].each do |todo_id|
      Todo.find(todo_id.to_i).set_done = true
    end
    redirect_to :action => "index"
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = Todo.new(params[:todo])
    
    if request.xhr?
      # AJAX request
      respond_to do |format|
      if @todo.save
          format.html { render :partial => "line" }
        else
          render :status => 403
        end
      end
    else
      respond_to do |format|
        if @todo.save
          format.html { redirect_to(:action => "index", :notice => 'Todo was successfully created.') }
          format.xml  { render :xml => @todo, :status => :created, :location => @todo }
        else
          format.html { redirect_to(:action => "index", :notice => 'Unable to create. Please try again.') }
          format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])
    
    if request.xhr?
      # AJAX request
      respond_to do |format|
      if @todo.update_attributes(params[:todo])
          format.html { render :partial => "line" }
        else
          render :status => 403
        end
      end
    else
      respond_to do |format|
        if @todo.update_attributes(params[:todo])
          format.html { redirect_to(@todo, :notice => 'Todo was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def tag
    @todos = []
    tag = Tag.first(:conditions => { :label => params[:tag].downcase })
    @todos = tag.todos.select {|t| !t.done && t.is_current? } if !tag.nil?
    @header = params[:tag]
    
    respond_to do |format|
      format.html { render :index }
    end
  end
end
