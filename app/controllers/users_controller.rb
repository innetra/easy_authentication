class UsersController < ApplicationController

  def index
    @users = User.all(:order => :login)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = t('users.create.flash.notice', :login => @user.login)
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash[:error] = t('users.create.flash.error')
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t('users.update.flash.notice', :login => @user.login)
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        flash[:error] = t('users.update.flash.error')
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def password
    @user = User.find_by_login(params[:id])
  end

end
