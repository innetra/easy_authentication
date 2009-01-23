require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('easy_authentication', '1.0.0') do |e|
  e.description    = "Easy Role Authentication for Ruby on Rails 2.2 (i18n)"
  e.url            = "http://github.com/innetra/easy_authentication"
  e.author         = "Ivan Torres"
  e.email          = "mexpolk@gmail.com"
  e.ignore_pattern = ["tmp/*", "script/*"]
  e.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].each { |f| load f }
