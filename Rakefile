require 'pathname'

STEP_DIRS = Dir['*'].
  reject{|fn| not Pathname.new(fn).directory?}.
  reject{|fn| fn !~ /^\d/ }.
  sort


# Tasks #######################################

task default: [:clean, :all]

TASKS = {
  names:        STEP_DIRS.map{|dir| /^\d+/.match(dir)[0].to_i.to_s.to_sym},
  descriptions: STEP_DIRS.map{|dir| /^\d+\W*(\w.*)$/.match(dir)[1].strip},
  dependencies: Array.new(STEP_DIRS.size)
}

0.upto(STEP_DIRS.size-1) do |i|
  TASKS[:dependencies][i] = []
  next if i.zero?

  (i-1).downto(0) do |j|
    TASKS[:dependencies][i].unshift TASKS[:names][j]
  end
end

#desc 'publish to rubyforge.org and git origin (do "git add untracked_file" beforehand if needed !!!)'
desc TASKS[:descriptions].last
task all: ([:clean] + TASKS[:names])

0.upto(STEP_DIRS.size-1) do |i|

  desc TASKS[:descriptions][i]
  task TASKS[:names][i] => TASKS[:dependencies][i] do
    sh "cd '#{STEP_DIRS[i]}'; rake"
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
