namespace :easy_authentication do
  desc "Create sysadmin user"
  task :sysadmin => :environment do

    unless User.find_by_login("sysadmin")

      right_ids = []

      for right in Right.all do
        right_ids << right.id
      end

      Role.create!( :name => "sysadmin",
                    :right_ids => right_ids )


      User.create!( :first_name => "System",
                    :last_name => "Administrator",
                    :login => "sysadmin",
                    :password => "monkey",
                    :password_confirmation => "monkey",
                    :email => "sysadmin@innetra.com",
                    :role_ids => [1] )

    end
  end
end
