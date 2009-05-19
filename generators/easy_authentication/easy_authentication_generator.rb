require "digest/sha1"
class EasyAuthenticationGenerator < Rails::Generator::Base

  default_options :skip_migrations => false

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

    def banner
      "Usage: #{$0} easy_authentication"
    end

    def add_options!(opt)
      opt.separator ""
      opt.separator "Options:"
      opt.on("--skip-migrations",
        "Don't generate migrations") { |v| options[:skip_migrations] = v }
    end

end
