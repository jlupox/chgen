require "chgen/version"

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
    end
end
