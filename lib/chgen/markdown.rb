require 'yaml'

module Chgen

    module Markdown
        extend self

        module Error;
            def self.exception(*args)
                RuntimeError.new(*args).extend(self)
            end
        end
        class MarkdownError < RuntimeError; include Error end

        def parse(filename)
            raise MarkdownError, "The file must exist to analize" unless File.exists?(filename)
            begin
                yaml = YAML.load(File.open(filename)) || {}
            rescue Psych::SyntaxError
                raise MarkdownError, "Error loading the YAML file"
            end

            markdown = "## " + yaml.delete("Title") { |el| "#{el} not found" }
            sections = yaml.keys

            sections.each do |section|
                markdown << "\n\n### #{yaml[section]['title']}\n" unless yaml[section]['title'].nil?
                commands = yaml[section]['commands'] || []
                # markdown << "\n```"
                commands.each do |command, value|
                    markdown << "\n  * **``#{command}``** - #{value}"
                    # markdown << "\n#{command} - #{value}"
                end
                # markdown << "\n```"
            end
            return markdown
        end
    end
end
