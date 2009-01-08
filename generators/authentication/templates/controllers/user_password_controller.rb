class UserPasswordController < ApplicationController

  <% unless options[:skip_layouts] -%>
    layout "authentication"
  <% end -%>

  def edit
    @user = User.first(:conditions => "login = '#{params[:id]}' OR email = '#{params[:id]}'")
  end

  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      debugger
      if @user.authenticated?(params[:user][:current_password])
        if @user.update_attributes(params[:user])
          flash[:notice] = t("user_password.edit.flash.update")
          format.html { redirect_to(home_url) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors,
              :status => :unprocessable_entity }
        end
      else
        flash[:error] = t("user_password.edit.flash.update_error")
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
              :status => :unprocessable_entity }
      end
    end
  end

end
