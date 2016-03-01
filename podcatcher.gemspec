# Gem description, including dependencies
Gem::Specification.new do |s|
  # Metadata #############################################################
  s.name        = 'podcatcher'
  s.version     = '3.1.8'
  s.authors     = ['Doga Armangil']
  s.email       = ['doga.armangil@alumni.epfl.ch']
  s.homepage    = 'https://github.com/doga/podcatcher'
  s.summary     = 'Armangil\'s podcatcher is a podcast client for the command line.'

  # SPDX IDs of chosen licenses (see http://spdx.org/licenses/)
  s.licenses    = Dir['*-LICENSE*'].map{|filename| filename.split('-').first}

  #if s.respond_to? :metadata=
  s.metadata = {
    # List of RubyGems.org metadata that can be set manually on the gem webpage.
    # Can those be set automatically through the gem metadata?
    # - Source Code URL
    'code' => 'https://github.com/doga/podcatcher',
    # - Wiki URL
    'wiki' => nil,
    # - Mailing List URL
    'mail' => nil,
    # - Documentation URL
    'docs' => 'https://github.com/doga/podcatcher',
    # - Bug Tracker URL
    'bugs' => 'https://github.com/doga/podcatcher/issues'
  }
  #end

  s.has_rdoc = false # 
  s.extra_rdoc_files = []
  #s.rdoc_options << '--title' << 'Jsonapi for Rails'

  # Implementation #######################################################
  s.files = Dir[
    'bin/*', 
    'README*', '*-LICENSE*'
  ]
  bindir = 'bin'
  s.bindir = bindir # 'bin' is the default binary directory
  Dir.entries(bindir).reject{|dir| ['.', '..'].include? dir}.each do |binary|
    next if [
      # ignored binaries
      'test'
    ].include? binary
    s.executables << binary
  end

  # s.platform = Gem::Platform::RUBY # Gem::Platform::RUBY is the default, indicates a pure-Ruby gem.
  s.required_ruby_version = '>= 1.8.2'
end
