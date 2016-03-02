# Gem description, including dependencies
Gem::Specification.new do |s|
  # Metadata #############################################################
  s.name        = 'podcatcher'
  s.version     = '3.1.11'
  s.authors     = ['Doga Armangil']
  s.email       = ['doga.armangil@alumni.epfl.ch']
  s.homepage    = 'https://github.com/doga/podcatcher'
  s.summary     = 'Armangil\'s podcatcher is a podcast client for the command line.'

  # SPDX IDs of chosen licenses (see http://spdx.org/licenses/)
  s.licenses    = Dir['*-LICENSE*'].map{|filename| filename.split('-').first}

  #if s.respond_to? :metadata=
  s.metadata = {
    # List of RubyGems.org metadata that can be set manually on the gem webpage.
    # - Source Code URL
    'code' => 'https://github.com/doga/podcatcher',
    # - Documentation URL
    'docs' => 'https://github.com/doga/podcatcher',
    # - Wiki URL
    'wiki' => '',
    # - Mailing List URL
    'mail' => '',
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
    'README*', '*-LICENSE*',
    'certs/*.pem'
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


  # Sign gem #############################################################
  s.cert_chain = ['certs/doga.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
