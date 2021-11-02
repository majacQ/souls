require_relative "./output_scaffolds/scaffold_rspec_policy"

RSpec.describe(Souls::Generate) do
  describe "Generate Rspec Policy" do
    let(:class_name) { "user" }
    let(:file_name) { "user_policy_spec" }

    before do
      FakeFS do
        @file_dir = "./spec/policies/"
        FileUtils.mkdir_p(@file_dir) unless Dir.exist?(@file_dir)
        @schema_dir = "./db/"
        FileUtils.mkdir_p(@schema_dir) unless Dir.exist?(@schema_dir)
      end
    end

    it "creates mutation file" do
      file_path = "#{@file_dir}#{file_name}.rb"
      FakeFS.activate!
      File.open("#{@schema_dir}schema.rb", "w") {}
      a1 = Souls::Generate.new.rspec_policy("user")
      file_output = File.read(file_path)

      expect(a1).to(eq(file_path))
      expect(File.exists? file_path).to(eq(true))
      FakeFS.deactivate!

      expect(file_output).to(eq(OutputScaffold.scaffold_rspec_policy))
    end
  end
end
