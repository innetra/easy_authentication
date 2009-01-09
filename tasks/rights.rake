namespace :easy_authentication do
  desc "Read routes to create rights"
  task :rights => :environment do

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

  end
end
