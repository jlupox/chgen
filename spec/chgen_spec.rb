require_relative '../lib/chgen'

require 'aruba'
require 'aruba/api'

include Aruba::Api

require 'pathname'

root = Pathname.new(__FILE__).parent.parent

# Allows us to run commands directly, without worrying about the CWD
ENV['PATH'] = "#{root.join('bin').to_s}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

# http://fractio.nl/2013/12/06/cli-testing-with-rspec-and-cucumber-less-aruba/

describe "chgen" do
    it "should contain -f tag" do
        lambda {
            run_simple "chgen"
        }.should raise_error
    end
end
