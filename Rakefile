require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('easy_authentication', '2.0.0') do |e|
  e.description    = "Easy Role Authentication for Ruby on Rails 2.2 (i18n)"
  e.url            = "http://github.com/innetra/easy_authentication"
  e.author         = "Ivan Torres"
  e.email          = "mexpolk@gmail.com"
  e.ignore_pattern = ["tmp/*", "script/*"]
  e.development_dependencies = []
end

# When loading a plugin via rubygems, rake tasks aren't included:
# http://rails.lighthouseapp.com/projects/8994/tickets/59-when-loading-a-plugin-via-rubygems-rake-tasks-aren-t-included
# Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each { |f| load f }
