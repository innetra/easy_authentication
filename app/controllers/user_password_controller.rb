class UserPasswordController < ApplicationController

  skip_before_filter :login_required, :except => [ :edit, :update ]

  def edit
    @user = User.find_by_login(params[:id])
  end

  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      if @user.authenticated?(params[:user][:current_password])
        if @user.update_attributes(params[:user])
          flash[:notice] = t('user_password.update.flash.notice',
            :default => 'Password updated.')
          format.html { redirect_to(root_url) }
          format.xml  { head :ok }
        else
          format.html { render :action => 'edit' }
          format.xml  { render :xml => @user.errors,
              :status => :unprocessable_entity }
        end
      else
        flash[:error] = t('user_password.update.flash.error',
          :default => 'Password not updated.')
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @user.errors,
              :status => :unprocessable_entity }
      end
    end
  end

  def forgot_password
    respond_to do |format|
      format.html { render :layout => 'sessions' }
    end
  end

  def send_password_token

    if user = User.reset_password(params[:login])
      flash[:notice] = t('user_password.send_password_token.flash.notice',
        :default => 'Check your email for instructions.',
        :name => user.first_name, :email => user.email)
    else
      flash[:error] = t('user_password.send_password_token.flash.error',
        :default => 'There was an error reseting your password. ')
    end

    respond_to do |format|
      format.html { redirect_to(login_url) }
    end

  end

  def reset_password
    respond_to do |format|
      if @user = User.find_by_login_and_password_reset_token(params[:login], params[:token])
        format.html { render :layout => 'sessions' }
      else
        flash[:error] = t('user_password.reset_password.flash.error',
          :default => 'There was an error reseting your password.')
        format.html { redirect_to(login_url) }
      end
    end
  end

  def update_password
    @user = User.find_by_login_and_password_reset_token(params[:user][:login], params[:user][:password_reset_token])
    params[:user][:password_reset_token] = nil

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(login_url) }
      else
        flash[:error] = t('user_password.update_password.flash.error',
          'There was an error updating your password.')
        logger.info @user.errors.inspect
        format.html { render :action => 'reset_password' }
      end
    end
  end

end
