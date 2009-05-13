require "digest/sha1"
class EasyAuthenticationGenerator < Rails::Generator::Base

  default_options :skip_migrations => false, :skip_routes => false

  def manifest
    record do |m|

      # Stylesheets
      m.directory("public/stylesheets/sass")
      m.template "stylesheets/sass/easy_authentication.sass",
        "public/stylesheets/sass/easy_authentication.sass"

      # Site Keys
      unless defined? AUTH_SITE_KEY
        m.template "site_keys.rb", "config/initializers/site_keys.rb",
          :assigns => {
            :auth_site_key => make_token,
            :auth_digest_stretches => 10
          }
      end

      # Locales
      m.template "locales/en.easy_authentication.yml",
        "config/locales/en.easy_authentication.yml"
      m.template "locales/es.easy_authentication.yml",
        "config/locales/es.easy_authentication.yml"

      # Necessary Routes
      unless options[:skip_routes]
        generate_routes
      end

      # Migrations
      unless options[:skip_migrations]
        m.migration_template "migrations/easy_authentication.rb", "db/migrate",
          :migration_file_name => "create_easy_authentication"
      end

    end
  end

  protected

    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join("--"))
    end

    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end

    def banner
      "Usage: #{$0} easy_authentication"
    end

    def add_options!(opt)
      opt.separator ""
      opt.separator "Options:"
      opt.on("--skip-migrations",
        "Don't generate migrations") { |v| options[:skip_migrations] = v }
      opt.on("--skip-routes",
        "Don't map resources in routes file") { |v| options[:skip_routes] = v }
    end

    def gsub_file(relative_destination, regexp, *args, &block)
      path = destination_path(relative_destination)
      content = File.read(path).gsub(regexp, *args, &block)
      File.open(path, 'wb') { |file| file.write(content) }
    end

    def generate_routes
      sentinel = 'ActionController::Routing::Routes.draw do |map|'

      # Do not change indentation in this method!!!
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        %{#{match}\n
  # Easy Authentication
  map.login "/login", :controller => "sessions", :action => "new"
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  map.forgot_password "/forgot_password", :controller => "user_password",
    :action => "forgot_password"
  map.reset_password "/reset_password/:login/:token",
    :controller => "user_password", :action => "reset_password", :method => "get"
  map.reset_password "/reset_password",
    :controller => "user_password", :action => "update_password", :method => "post"
  map.change_password "/change_password", :controller => "user_password",
    :action => "edit"

  map.resources :roles
  map.resources :sessions, :only => [:create]
  map.resources :users
  map.resources :user_roles, :only => [:edit, :update]
  map.resources :user_password, :only => [:edit, :update]
  # Easy Authentication
        }
      end
    end
end
