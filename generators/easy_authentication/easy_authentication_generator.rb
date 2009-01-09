require "digest/sha1"
class EasyAuthenticationGenerator < Rails::Generator::Base

  default_options :skip_layout => false, :skip_migrations => false,
    :skip_routes => false

  def manifest
    record do |m|

      # Controllers
      controllers.each do |controller_name|
        m.template "controllers/#{controller_name}_controller.rb",
          File.join("app/controllers", "#{controller_name}_controller.rb")
        m.directory(File.join("app/views", controller_name))
      end

      # Helpers
      helpers.each do |helper_name|
        m.template "helpers/#{helper_name}_helper.rb",
          File.join("app/helpers", "#{helper_name}_helper.rb")
      end

      # Views
      views.each do |view_name|
        m.template "views/#{view_name}.html.erb",
          File.join("app/views", "#{view_name}.html.erb")
      end

      # Sessions Layout
      unless options[:skip_layouts]
        m.directory("app/views/layouts")
        layouts.each do |layout_name|
          m.template "layouts/#{layout_name}.erb",
            File.join("app/views/layouts", "#{layout_name}.erb")
        end
      end

      # Stylesheets
      unless options[:skip_css]
        m.directory("public/stylesheets/easy_authentication")
        stylesheets.each do |stylesheet_name|
          m.template "stylesheets/#{stylesheet_name}.css",
            File.join("public/stylesheets/easy_authentication", "#{stylesheet_name}.css")
        end
      end

      # Models
      models.each do |model_name|
        m.template "models/#{model_name}.rb",
          File.join("app/models", "#{model_name}.rb")
      end

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
      m.template "locales/es-MX.easy_authentication.yml",
        "config/locales/es-MX.easy_authentication.yml"

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

    def controllers
      %w[ roles sessions user_roles users user_password ]
    end

    def helpers
      %w[ form shadowbox ]
    end

    def views
      %w[ roles/edit roles/_form roles/index roles/new roles/show sessions/new
        user_roles/edit users/edit users/index users/new users/show users/_user
        users/_form user_password/edit user_password/forgot_password
        user_password/reset_password ]
    end

    def layouts
      %w[ easy_authentication easy_authentication_login ]
    end

    def stylesheets
      %w[ default login roles users ]
    end

    def models
      %w[ right role user ]
    end

    def banner
      "Usage: #{$0} easy_authentication"
    end

    def add_options!(opt)
      opt.separator ""
      opt.separator "Options:"
      opt.on("--skip-layout",
        "Don't generate the authentication layout for views (I'll user my own)") { |v| options[:skip_layout] = v }
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
