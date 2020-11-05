module Souls
  module Init
    class << self
      def config
        FileUtils.mkdir_p "config" unless File.directory? "config"
        file_path = "config/initialize.rb"
        File.open(file_path, "a") do |f|
          f.write <<~EOS
            Souls.configure do |config|
              config.project_id = "elsoul2"
              config.app = "grpc-td-cluster"
              config.network = "default"
              config.machine_type = "custom-1-6656"
              config.zone = "us-central1-a"
              config.domain = "el-soul.com"
              config.google_application_credentials = "./config/credentials.json"
            end
          EOS
        end
        file_path = ".irbrc"
        File.open(file_path, "a") do |f|
          f.write <<~EOS
            require "yaml"
            require "erb"
            require "active_record"
            require "logger"

            $LOAD_PATH << "#{Dir.pwd}/app/services"

            Dir[File.expand_path "app/*.rb"].each do |file|
              require file
            end

            db_conf = YAML.safe_load(ERB.new(File.read("./config/database.yml")).result)
            ActiveRecord::Base.establish_connection(db_conf)
            Dir[File.expand_path "./app/controllers/*.rb"].sort.each do |file|
              require file
            end
          EOS
        end
        puts "Update Your Config in `./config/initializer.rb` \n and \n Souls All Set!!"
      end
    end
  end
end
