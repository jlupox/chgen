require "bundler/gem_tasks"

require 'cucumber/rake/task'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]

# task :default => :test

# desc 'run the tests' # that's non-DRY
# task :test do
#       sh 'rspec spec'
# end

task :man do
  mkdir_p "build"
  File.write "README.md.ron", File.read("README.md").gsub("\u200c", "* ")
  sh 'ronn --roff --manual="Chgen manual" README.md.ron'
  rm 'README.md.ron'
  mv 'README.1', 'build/chgen.1'
end

task :standalone do
  mkdir_p "build"
  File.open("build/chgen", "w") do |f|
    f.puts "#!/usr/bin/env ruby"
    f.puts "# This is generated from https://github.com/jlupox/chgen using 'rake standalone'"
    f.puts "# any changes will be overwritten."
    f.puts File.read("lib/chgen.rb")

    f.puts File.read("bin/chgen").gsub(/^require.*chgen.*\n/, '');
  end
  sh 'chmod +x build/chgen'
end

task :build => [:man, :standalone]

desc "Install standalone script and man pages"
task :install => :standalone do
  prefix = ENV['PREFIX'] || ENV['prefix'] || '/usr/local'

  FileUtils.mkdir_p "#{prefix}/bin"
  FileUtils.cp "build/chgen", "#{prefix}/bin"

  FileUtils.mkdir_p "#{prefix}/share/man/man1"
  FileUtils.cp "build/chgen.1", "#{prefix}/share/man/man1"
end

