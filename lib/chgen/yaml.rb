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
            Chgen::Markdown.parse(yaml_url)
        end
    end
end
