class SessionsController < ApplicationController

  skip_before_filter :login_required

  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = t("sessions.create.flash.notice", :default => 'Welcome {{full_name}}.', :full_name => user.full_name)
    else
      log_failed_login
      flash[:error] = t("sessions.create.flash.error", :default => 'User or Password incorrect.')
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = t("sessions.destroy.flash.notice", :default => 'Your session has ended.')
    redirect_back_or_default('/')
  end

  protected

    def log_failed_login
      logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
    end

end
