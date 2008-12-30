namespace :authentication do
  desc "Create sysadmin user"
  task :sysadmin => :environment do

    unless User.find_by_login("sysadmin")

      right_ids = []

      for right in Right.all do
        right_ids << right.id
      end

      Role.create!(:name => "sysadmin",
        :right_ids => right_ids)

      if !defined?(Person)
        User.create!(:name => "System",
          :last_name => "Administrator",
          :login => "sysadmin",
          :password => "monkey",
          :password_confirmation => "monkey",
          :email => "sysadmin@innetra.com",
          :role_ids => [1])
      else
      end

    end

  end
end
