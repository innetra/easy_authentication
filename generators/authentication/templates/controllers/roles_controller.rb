class RolesController < ApplicationController

<% unless options[:skip_layouts] -%>
  layout "authentication"
<% end -%>

  def index
    @roles = Role.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  def new
    @role = Role.new
    @right_groups = Right.all(:order => "controller_name, action_name").group_by { |p| p.controller_name }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  def create
    params[:role][:right_ids] ||= []
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = t("roles.flash.create")
        format.html { redirect_to(@role) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @role = Role.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  def edit
    @role = Role.find_by_id(params[:id])
    @right_groups = Right.all(:order => "controller_name, action_name").group_by { |p| p.controller_name }
  end

  def update
    @role = Role.find_by_id(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = t("roles.flash.update")
        format.html { redirect_to(@role) }
        format.xml  { head :ok }
      else
        @right_groups = Right.all(:order => "controller_name, action_name").group_by { |p| p.controller_name }
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def assign
    @user = User.find_by_login(params[:user_id])
    @roles = Role.all
  end


end
