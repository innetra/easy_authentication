# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easy_authentication}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Torres"]
  s.date = %q{2009-01-23}
  s.description = %q{Easy Role Authentication for Ruby on Rails 2.2 (i18n)}
  s.email = %q{mexpolk@gmail.com}
  s.extra_rdoc_files = ["tasks/sysadmin.rake", "tasks/rights.rake", "lib/user_methods.rb", "lib/password_authentication.rb", "lib/helper_methods.rb", "lib/controller_methods.rb", "lib/cookie_authentication.rb"]
  s.files = ["Manifest", "tasks/sysadmin.rake", "tasks/rights.rake", "generators/easy_authentication/templates/stylesheets/users.css", "generators/easy_authentication/templates/stylesheets/login.css", "generators/easy_authentication/templates/stylesheets/roles.css", "generators/easy_authentication/templates/stylesheets/default.css", "generators/easy_authentication/templates/helpers/shadowbox_helper.rb", "generators/easy_authentication/templates/helpers/form_helper.rb", "generators/easy_authentication/templates/migrations/easy_authentication.rb", "generators/easy_authentication/templates/views/user_roles/edit.html.erb", "generators/easy_authentication/templates/views/user_password/edit.html.erb", "generators/easy_authentication/templates/views/user_password/reset_password.html.erb", "generators/easy_authentication/templates/views/user_password/forgot_password.html.erb", "generators/easy_authentication/templates/views/sessions/new.html.erb", "generators/easy_authentication/templates/views/users/index.html.erb", "generators/easy_authentication/templates/views/users/show.html.erb", "generators/easy_authentication/templates/views/users/_user.html.erb", "generators/easy_authentication/templates/views/users/edit.html.erb", "generators/easy_authentication/templates/views/users/new.html.erb", "generators/easy_authentication/templates/views/users/_form.html.erb", "generators/easy_authentication/templates/views/roles/index.html.erb", "generators/easy_authentication/templates/views/roles/show.html.erb", "generators/easy_authentication/templates/views/roles/edit.html.erb", "generators/easy_authentication/templates/views/roles/new.html.erb", "generators/easy_authentication/templates/views/roles/_form.html.erb", "generators/easy_authentication/templates/site_keys.rb", "generators/easy_authentication/templates/models/user_mailer.rb", "generators/easy_authentication/templates/models/right.rb", "generators/easy_authentication/templates/models/user.rb", "generators/easy_authentication/templates/models/role.rb", "generators/easy_authentication/templates/controllers/user_roles_controller.rb", "generators/easy_authentication/templates/controllers/sessions_controller.rb", "generators/easy_authentication/templates/controllers/roles_controller.rb", "generators/easy_authentication/templates/controllers/user_password_controller.rb", "generators/easy_authentication/templates/controllers/users_controller.rb", "generators/easy_authentication/templates/locales/en.easy_authentication.yml", "generators/easy_authentication/templates/locales/es-MX.easy_authentication.yml", "generators/easy_authentication/templates/layouts/easy_authentication_login.erb", "generators/easy_authentication/templates/layouts/easy_authentication.erb", "generators/easy_authentication/easy_authentication_generator.rb", "test/test_helper.rb", "test/easy_authentication_test.rb", "Rakefile", "init.rb", "lib/user_methods.rb", "lib/password_authentication.rb", "lib/helper_methods.rb", "lib/controller_methods.rb", "lib/cookie_authentication.rb", "easy_authentication.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/innetra/easy_authentication}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Easy_authentication"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easy_authentication}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Easy Role Authentication for Ruby on Rails 2.2 (i18n)}
  s.test_files = ["test/test_helper.rb", "test/easy_authentication_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
