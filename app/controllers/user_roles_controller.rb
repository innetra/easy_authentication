class UserRolesController < ApplicationController

  before_filter :load_roles

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t("user_roles.update.flash.notice", :default => 'User Role updated.')
        format.html { redirect_to(user_url(@user)) }
        format.xml  { head :ok }
      else
        flash[:error] = t("user_roles.update.flash.error", :default => 'User Role not updated.')
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

    def load_roles
      @roles = Role.all
    end

end
