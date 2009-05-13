namespace :easy_authentication do
  desc "Read routes to create rights"
  task :init => :environment do

    controllers = {}

    # Inserts unregistered actions
    ActionController::Routing::Routes.routes.each do |route|
      if route.parameter_shell.has_key?(:controller)
        unless controllers.has_key? route.parameter_shell[:controller]
          controllers[route.parameter_shell[:controller]] = []
        end
        unless controllers[route.parameter_shell[:controller]].include? route.parameter_shell[:action]
          controllers[route.parameter_shell[:controller]] << route.parameter_shell[:action]
        end
        unless Right.find_by_controller_name_and_action_name(
          route.parameter_shell[:controller], route.parameter_shell[:action])
          Right.create!(
            :controller_name => route.parameter_shell[:controller],
            :action_name => route.parameter_shell[:action])
        end
      end
    end

    # De-Register invalid actions
    Right.all.each do |right|
      if (controllers.has_key? right.controller_name)
        right.delete unless controllers[right.controller_name].include? right.action_name
      else
        right.delete
      end
    end

    # Initialize rights
    right_ids = []

    unless sysadmin_role = Role.find_by_name('sysadmin')
      sysadmin_role = Role.create!( :name => "sysadmin",
                    :right_ids => right_ids )
    end

    # Gets all registered rights
    for right in Right.all do
      right_ids << right.id
    end

    # Assign all rights to sysadmin role
    sysadmin_role.right_ids = right_ids
    sysadmin_role.save

    # Create sysadmin user
    unless User.find_by_login("sysadmin")

      User.create!( :first_name => "System",
                    :last_name => "Administrator",
                    :login => "sysadmin",
                    :password => "monkey",
                    :password_confirmation => "monkey",
                    :email => "sysadmin@innetra.com",
                    :role_ids => [sysadmin_role.id] )
    end

  end
end
