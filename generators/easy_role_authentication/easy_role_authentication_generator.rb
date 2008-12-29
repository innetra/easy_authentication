class EasyRoleAuthenticationGenerator < Rails::Generator::NamedBase

  default_options :skip_migration => false, :use_easy_contacts => false

  def manifest
    record do |m|
      puts "class_name: #{class_name}"
      puts "class_path: #{class_path}"
      puts "file_name: #{file_name}"
    end
  end



end
