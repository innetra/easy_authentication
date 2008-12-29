# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easy_role_authentication}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Torres"]
  s.date = %q{2008-12-29}
  s.description = %q{Easy Role Authentication for Ruby on Rails 2.2 (i18n)}
  s.email = %q{mexpolk@gmail.com}
  s.extra_rdoc_files = ["tasks/rights.rake", "lib/user_mixin.rb", "lib/password_authentication.rb", "lib/user_helper.rb", "lib/cookie_authentication.rb"]
  s.files = ["easy_role_authentication.gemspec", "Manifest", "tasks/rights.rake", "generators/easy_role_authentication/templates/stylesheets/users.css", "generators/easy_role_authentication/templates/stylesheets/new.css", "generators/easy_role_authentication/templates/stylesheets/sessions.css", "generators/easy_role_authentication/templates/migrations/create_rights_roles.rb", "generators/easy_role_authentication/templates/migrations/create_users.rb", "generators/easy_role_authentication/templates/migrations/create_rights.rb", "generators/easy_role_authentication/templates/migrations/create_roles.rb", "generators/easy_role_authentication/templates/migrations/create_roles_users.rb", "generators/easy_role_authentication/templates/views/user_roles/edit.html.erb", "generators/easy_role_authentication/templates/views/sessions/new.html.erb", "generators/easy_role_authentication/templates/views/users/index.html.erb", "generators/easy_role_authentication/templates/views/users/show.html.erb", "generators/easy_role_authentication/templates/views/users/_user.html.erb", "generators/easy_role_authentication/templates/views/users/edit.html.erb", "generators/easy_role_authentication/templates/views/users/new.html.erb", "generators/easy_role_authentication/templates/views/roles/index.html.erb", "generators/easy_role_authentication/templates/views/roles/show.html.erb", "generators/easy_role_authentication/templates/views/roles/edit.html.erb", "generators/easy_role_authentication/templates/views/roles/new.html.erb", "generators/easy_role_authentication/templates/views/roles/_form.html.erb", "generators/easy_role_authentication/templates/models/rights_roles.rb", "generators/easy_role_authentication/templates/models/right.rb", "generators/easy_role_authentication/templates/models/user.rb", "generators/easy_role_authentication/templates/models/roles_users.rb", "generators/easy_role_authentication/templates/models/role.rb", "generators/easy_role_authentication/templates/models/activity_log.rb", "generators/easy_role_authentication/templates/controllers/user_roles_controller.rb", "generators/easy_role_authentication/templates/controllers/sessions_controller.rb", "generators/easy_role_authentication/templates/controllers/roles_controller.rb", "generators/easy_role_authentication/templates/controllers/users_controller.rb", "generators/easy_role_authentication/templates/layouts/sessions.erb", "generators/easy_role_authentication/easy_role_authentication_generator.rb", "test/test_helper.rb", "test/easy_role_authentication_test.rb", "Rakefile", "init.rb", "lib/user_mixin.rb", "lib/password_authentication.rb", "lib/user_helper.rb", "lib/cookie_authentication.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/innetra/easy_role_authentication}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Easy_role_authentication"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easy_role_authentication}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Easy Role Authentication for Ruby on Rails 2.2 (i18n)}
  s.test_files = ["test/test_helper.rb", "test/easy_role_authentication_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
