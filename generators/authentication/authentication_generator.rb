require "digest/sha1"
class AuthenticationGenerator < Rails::Generator::Base

  default_options :use_easy_contacts => false

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
        m.directory("public/stylesheets/sessions")
        stylesheets.each do |stylesheet_name|
          m.template "stylesheets/#{stylesheet_name}.css",
            File.join("public/stylesheets", "#{stylesheet_name}.css")
        end
      end

      # Migrations
      unless options[:skip_migrations]
        m.migration_template "migrations/authentications.rb", "db/migrate",
          :assigns => { :migration_name => "CreateAuthentications" },
          :migration_file_name => "create_authentications"
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
      m.template "locales/en.authentication.yml",
        "config/locales/en.authentication.yml"
      m.template "locales/es-MX.authentication.yml",
        "config/locales/es-MX.authentication.yml"

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
      %w[ roles sessions user_roles users ]
    end

    def helpers
      %w[ form shadowbox ]
    end

    def views
      %w[ roles/edit roles/_form roles/index roles/new roles/show sessions/new
        user_roles/edit users/edit users/index users/new users/show users/_user ]
    end

    def layouts
      %w[ authentication sessions ]
    end

    def stylesheets
      %w[ default elements layout navigation template print roles sessions users ]
    end

    def migrations
      %w[ rights rights_roles roles roles_users users ]
    end

    def models
      %w[ right role user ]
    end

    def banner
      "Usage: #{$0} authenticated"
    end

    def add_options!(opt)
      opt.separator ""
      opt.separator "Options:"
      opt.on("--skip-layouts",
        "Don't generate the authentication layout for views (I'll user my own)") { |v| options[:skip_layouts] = v }
      opt.on("--skip-css",
        "Don't generate css files for views (I'll user my own)") { |v| options[:skip_css] = v }
      opt.on("--skip-migrations",
        "Don't generate migrations") { |v| options[:skip_migrations] = v }
    end

end
