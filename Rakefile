MAN_TITLE = 'Podcatcher Manual'

task default: :all

# If a file is not tracked, then do 'git add ...' beforehand !!!
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
    sh "ronn --manual '#{MAN_TITLE}' -s toc --roff --html *.ronn"
    cd '..'
  end

  namespace :git do

    desc 'add man pages to git'
    task :add do
      sh "git add man"
    end

    desc 'add and commit man pages to git'
    task all: [:add]

  end


  desc 'build man pages, then add and commit them to git'
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

  desc 'publish the git repository'
  task :push do
    sh 'git push -u origin master'
  end

  desc 'publish the git repository'
  task all: [:commit, :push]

end


namespace :gem do

  desc 'build the gem'
  task build: Dir['*.gemspec'] do |t|
    sh "gem build #{t.prerequisites.first}"
  end

  desc 'publish the gem'
  task push: [:build] do
    sh 'gem push *.gem'
  end

  desc 'build and publish the ruby gem'
  task all: [:build, :push]

end

# cleanup #################

# define task :clean
require 'rake/clean'

CLEAN.include '*.gem'
