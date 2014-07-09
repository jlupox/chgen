require 'chgen/version'
require 'chgen/markdown'
require 'chgen/yaml'

require 'gist'
require 'yaml'

module Chgen
    extend self

    module Error;
        def self.exception(*args)
            RuntimeError.new(*args).extend(self)
        end
    end
    class ChgenError < RuntimeError; include Error end

    def create(filename, options = {})

        raise ChgenError, "The Cheat Sheet already exists" if File.exists?(filename)
        raise ChgenError, "File extension must be .yaml" unless ".yaml".eql? File.extname(filename)
        raise ChgenError, "Is neccesarry to gist login => see gist --help" unless File.exists?(Gist.auth_token_file)

        # Yaml Gist url
        yaml_url = Gist.gist({}.to_yaml,
                             :filename => filename,
                             :output => :html_url)

        # Markdown Gist url
        md_url = Gist.gist("Cheat Sheet generator",
                           :filename => File.basename(filename, ".*") + '.md',
                           :output => :html_url)

        # Create the yaml Gist
        markdown = Chgen::Yaml.create_yaml(filename, yaml_url, md_url)
        # markdown = create_yaml(filename, yaml_url, md_url)

        # Update Markdown Gist
        Gist.gist(markdown,
                  :filename => File.basename(filename, ".*") + '.md',
                  :update => md_url)
    end

    def sync(path)
            if File.directory?(path)
                Chgen::Yaml.sync_directory(path)
            else
                Chgen::Yaml.sync(path)
            end
    end

end
