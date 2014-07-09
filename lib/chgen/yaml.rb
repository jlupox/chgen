require 'yaml'
require 'chgen/markdown'

module Chgen

    module Yaml
        extend self

        module Error;
            def self.exception(*args)
                RuntimeError.new(*args).extend(self)
            end
        end
        class YamlError < RuntimeError; include Error end

        # Create a blank yaml Cheat Sheet from existing [yaml, md] Gists
        def create_yaml(filename, yaml_url, md_url)
            yaml = {}
            yaml["yaml_url"] = yaml_url
            yaml["md_url"] = md_url
            yaml["Title"] = "Cheat Sheet title"
            File.open(filename, "w") { |f| YAML.dump(yaml, f) }

            content = File.read(filename)
            Gist.gist(content,
                      :filename => filename,
                      :update => yaml_url)

            yaml_url = filename
            Chgen::Markdown.parse_file(yaml_url)
        end

        def sync_file(filename)
            raise YamlError, "The path does not exist" unless File.exists?(filename)
            raise YamlError, "File extension must be .yaml" unless ".yaml".eql? File.extname(filename)
            begin
                yaml = YAML.load(File.open(filename)) || {}
            rescue Psych::SyntaxError
                raise YamlError, "Error loading the YAML file"
            end

            raise YamlError, "Cheat Sheet without yaml_url" unless yaml.has_key?("yaml_url")
            raise YamlError, "Cheat Sheet without md_url" unless yaml.has_key?("md_url")
            raise YamlError, "Cheat Sheet without Title" unless yaml.has_key?("Title")

            markdown = Chgen::Markdown.parse(yaml)
            Gist.gist(markdown,
                      :filename => File.basename(filename, ".*") + '.md',
                      :update => yaml["md_url"])
        end

        def sync_directory(path)
        end

    end
end
