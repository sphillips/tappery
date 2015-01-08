class FriendshipsController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index, :show, :new, :create, :update, :destroy, :truncate]

  # GET /friendships
  # GET /friendships.xml
  def index
    friendships = Friendship.find(:all, :select => "id,friend_id,status", :conditions => ["user_id = ?", params[:user_id]])

    respond_to do |format|
      format.json { render :json => friendships }
      # format.html # index.html.erb
      # format.xml  { render :xml => @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.xml
  def show
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.xml
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friendships.xml
  def create
    @friendship = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", params[:user_id], params[:friend_id]])
    @sister = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", params[:friend_id], params[:user_id]])
    if @friendship.nil?
      @friendship = Friendship.create(:user_id => params[:user_id], :friend_id => params[:friend_id], :status => params[:status])
      @sister = Friendship.create(:user_id => params[:friend_id], :friend_id => params[:user_id], :status => params[:status])
    end

    respond_to do |format|
      if @friendship.update_attributes(:status => params[:status]) && @sister.update_attributes(:status => params[:status])
        # format.html { redirect_to(@friendship, :notice => 'Friendship was successfully created.') }
        format.json { render :json => @friendship }
        format.xml  { render :xml => @friendship, :status => :created, :location => @friendship }
      else
        format.json { render :json => @friendship.errors, :status => :unprocessable_entity }
        format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/update
  def update
    status = params[:status]
    @friendship = Friendship.find(:first, :conditions => ["user_id = ? AND friend_id = ?", params[:user_id], params[:friend_id]])
      respond_to do |format|
        if @friendship.update_both(status)
          format.json { render :json => @friendship }
          format.xml  { head :ok }
        else
          format.json { render :json => @friendship.errors, :status => :unprocessable_entity }
          format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
        end
      end 
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.xml
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.delete_both

    respond_to do |format|
      output = {'success' => 'true'}.to_json
      # output = 1
      format.json { render :json => output, :status => 200 }
      format.xml  { head :ok }
    end
  end

  def truncate #remove for production
    Friendship.destroy_all
    respond_to do |format|
      output = {'success' => 'true'}.to_json
      # output = 1
      format.html
      format.json { render :json => output, :status => 200 }
      format.xml  { head :ok }
    end
  end

end
