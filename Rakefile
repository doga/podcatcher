require 'pathname'

STEP_DIRS = Dir['*'].
  reject{|fn| not Pathname.new(fn).directory?}.
  reject{|fn| fn !~ /^\d/ }.
  sort

# Tasks #######################################

task default: [:clean, :all]

desc 'publish to rubyforge.org and git origin (do "git add untracked_file" beforehand if needed !!!)'
task all: STEP_DIRS

STEP_DIRS.each do |step_dir|
  task step_dir do
    sh "cd '#{step_dir}'; rake"
  end
end


# Cleanup #################

# Define task named :clean.
# Do not delete any file from project dir.
require 'rake/clean'
STEP_DIRS[1..-1].each do |step_dir|
  Dir["#{step_dir}/*"].each do |filename|

    # Do not delete Rakefiles and gemspecs
    next if filename.pathmap('%f') == 'Rakefile'
    next if filename.pathmap('%x') == '.gemspec'

    CLEAN.include filename
  end
end
