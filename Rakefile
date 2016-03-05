# Task parameters ##################################
PARAMS = {
  gemspec:   nil
}

# Capture gem specification by 'eval'ing the *.gemspec file
# using a fake Gem::Specification class
begin
  require 'ostruct'
  require 'pathname'
  module Gem
    class Specification
      def initialize 
        @spec = OpenStruct.new
        @spec.executables = []
        yield @spec
        #$stderr.puts "#{@spec.inspect}" 
        ::PARAMS[:gemspec] = @spec
      end
    end
  end
  def read_gem_name_from_gemspec
    gemspec = Dir['*.gemspec'].first
    return unless gemspec
    gemspec = Pathname.new(gemspec).read()
    self.instance_eval gemspec
    #$stderr.puts "#{PARAMS.inspect}" 
  end
  read_gem_name_from_gemspec
end


# Tasks #######################################

task default: :all

# If a file is not tracked, then do 'git add ...' beforehand if needed !!!
desc 'publish to rubyforge.org and git origin (do "git add untracked_file" beforehand if needed !!!)'
task all: [
  :clean, 
  'man:all', 
  'git:all', 
  'gem:all'
]

namespace :man do

  desc 'build man pages'
  task :build do
    cd 'man'
    sh "ronn --manual '#{PARAMS[:gemspec].name} manual' -s toc --roff --html *.ronn"
    cd '..'
  end

  namespace :git do

    desc 'add the man pages to git'
    task :add do
      sh "git add man"
    end

    desc 'add and commit the man pages to git'
    task all: [:add]

  end


  desc 'build the man pages, then add and commit them to git'
  task all: [:build, 'git:all']

end


namespace :git do

  desc 'commit all tracked files'
  task :commit do
    message = nil
    loop do
      print 'Commit message for tracked files: '
      message = gets.strip
      break unless message.index("'")
      puts "Please enter a message without single quotes (')."
    end
    sh "git commit -am '#{message}'"
  end

  desc 'add version tag'
  task :tag do
    sh "git tag v#{PARAMS[:gemspec].version}"
  end

  desc 'publish the git repository'
  task :push do
    sh 'git push -u origin master'
  end

  desc 'publish the git repository'
  task all: [:commit, :tag, :push]

end


namespace :gem do

  desc "build the #{PARAMS[:gemspec].name} gem"
  task build: Dir['*.gemspec'] do |t|
    sh "gem build #{t.prerequisites.first}"
  end

  desc "publish the #{PARAMS[:gemspec].name} gem"
  task push: [:build] do
    sh 'gem push *.gem'
  end

  desc "build and publish the #{PARAMS[:gemspec].name} gem"
  task all: [:build, :push]

  desc "install the #{PARAMS[:gemspec].name} gem on the local machine"
  task :install do
    sh "gem install #{PARAMS[:gemspec].name}"
    sh "gem cleanup #{PARAMS[:gemspec].name}"
    sh "rubygems_my_setup"
  end

end

# cleanup #################

# define task named :clean
require 'rake/clean'

CLEAN.include '*.gem'
