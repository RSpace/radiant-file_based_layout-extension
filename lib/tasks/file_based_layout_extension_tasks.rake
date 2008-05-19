namespace :radiant do
  namespace :extensions do
    namespace :file_based_layout do
      
      desc "Runs the migration of the File Based Layout extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          FileBasedLayoutExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          FileBasedLayoutExtension.migrator.migrate
        end
      end
    
    end
  end
end