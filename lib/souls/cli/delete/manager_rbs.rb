module Souls
  class Delete < Thor
    desc "manager_rbs [CLASS_NAME]", "Delete SOULs Manager RBS Template"
    method_option :mutation, aliases: "--mutation", required: true, desc: "Mutation File Name"
    def manager_rbs(class_name)
      file_path = ""
      singularized_class_name = class_name.underscore.singularize
      Dir.chdir(Souls.get_mother_path.to_s) do
        file_dir = "./sig/api/app/graphql/mutations/managers/#{singularized_class_name}_manager"
        FileUtils.mkdir_p(file_dir) unless Dir.exist?(file_dir)
        file_path = "#{file_dir}/#{options[:mutation]}.rbs"
        FileUtils.rm(file_path)
        puts(Paint % ["Deleted file! : %{white_text}", :yellow, { white_text: [file_path.to_s, :white] }])
      end
      file_path
    rescue Thor::Error => e
      raise(Thor::Error, e)
    end
  end
end