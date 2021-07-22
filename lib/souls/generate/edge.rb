module Souls
  module Generate
    def self.edge(class_name: "souls")
      singularized_class_name = class_name.underscore.singularize
      file_path = "./app/graphql/types/edges/#{singularized_class_name}_edge.rb"
      File.open(file_path, "w") do |f|
        f.write(<<~TEXT)
          class Types::#{singularized_class_name.camelize}Edge < Types::BaseEdge
            node_type(Types::#{singularized_class_name.camelize}Type)
          end
        TEXT
      end
      puts(Paint % ["Created file! : %{white_text}", :green, { white_text: [file_path.to_s, :white] }])
      file_path
    rescue StandardError => e
      raise(StandardError, e)
    end
  end
end