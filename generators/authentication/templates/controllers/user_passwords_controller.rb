class UserPasswordsController < ApplicationController

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User password was successfully updated."
        format.html { redirect_to(home_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
            :status => :unprocessable_entity }
      end
    end
  end

end
