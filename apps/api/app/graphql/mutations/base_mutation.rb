module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def fb_auth(token:)
      FirebaseIdToken::Certificates.request!
      sleep(3) if ENV["RACK_ENV"] == "development"
      @payload = FirebaseIdToken::Signature.verify(token)
      raise(ArgumentError, "Invalid or Missing Token") if @payload.blank?

      @payload
    end

    def pubsub_queue(topic_name: "send-mail-job", message: "text!")
      pubsub = Google::Cloud::Pubsub.new(project: ENV["PROJECT_ID"])
      topic = pubsub.topic(topic_name)
      topic.publish(message)
    end

    def graphql_query(mutation: "newCommentMailer", args: {})
      if args.blank?
        mutation_string = %(mutation { #{mutation.to_s.underscore.camelize(:lower)}(input: {}) { response } })
      else
        inputs = ""
        args.each do |key, value|
          inputs +=
            if value.instance_of?(String)
              "#{key.to_s.underscore.camelize(:lower)}: \"#{value}\" "
            else
              "#{key.to_s.underscore.camelize(:lower)}: #{value} "
            end
        end
        mutation_string = %(mutation { #{mutation.to_s.underscore.camelize(:lower)}(input: {#{inputs}}) { response } })
      end
      mutation_string
    rescue StandardError => e
      raise(StandardError, e)
    end

    def send_post(worker_name: "", mutation_string: "")
      port = get_worker(worker_name: worker_name)[0][:port]
      endpoint = Souls.configuration.endpoint
      res = Net::HTTP.post_form(URI.parse("http://localhost:#{port}#{endpoint}"), { query: mutation_string })
      res.body
    end

    def get_worker(worker_name: "")
      workers = Souls.configuration.workers
      workers.filter { |n| n[:name] == worker_name }
    end

    def check_user_permissions(user, obj, method)
      raise(StandardError, "Invalid or Missing Token") unless user

      policy_class = obj.class.name + "Policy"
      policy_clazz = policy_class.constantize.new(user, obj)
      permission = policy_clazz.public_send(method)
      raise(Pundit::NotAuthorizedError, "permission error!") unless permission
    end

    def auth_check(context)
      raise(GraphQL::ExecutionError, "You need to sign in!!") if context[:user].nil?
    end

    def get_token(token)
      JsonWebToken.decode(token)
    end

    def production?
      ENV["RACK_ENV"] == "production"
    end

    def get_instance_id
      `curl http://metadata.google.internal/computeMetadata/v1/instance/id -H Metadata-Flavor:Google`
    end
  end
end
