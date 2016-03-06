# Gem description, including dependencies
# (see http://guides.rubygems.org/specification-reference/)
Gem::Specification.new do |s|
  # Metadata #############################################################
  # BEWARE: this authoritative data is used for resolving ERB markup in project files!

  s.name        = 'podcatcher'
  s.version     = '3.2.6'
  s.authors     = ['Doga Armangil']
  s.email       = ['doga.armangil@alumni.epfl.ch']
  s.homepage    = 'https://github.com/doga/podcatcher'
  s.summary     = 'Armangil\'s podcatcher is a podcast client for the command line.'

  # SPDX IDs of chosen licenses (see http://spdx.org/licenses/)
  s.licenses    = Dir['*-LICENSE*'].map{|filename| filename.split('-').first}

  # Add metadata
  # if gem command supports Gemspec 2.0 or
  # if I am using an OpenStruct instance
  # for collecting data in my Rakefiles
  if s.respond_to?(:metadata=) or s.class.to_s == 'OpenStruct'
    s.metadata = {
    }
  end

  s.has_rdoc = false # 
  s.extra_rdoc_files = []
  #s.rdoc_options << '--title' << 'Jsonapi for Rails'

  # This message will be displayed after the gem is installed.
  s.post_install_message = "Congratulations! `podcatcher --version` shell command should now work."

  # Implementation #######################################################
  s.files = Dir[
    'bin/*', 
    'README*', '*-LICENSE*',
    'man/*.[15]',
    'certs/*.pem'
  ]

  # executables directory
  s.bindir = 'bin' # 'bin' is the default executables directory
  if Dir['bin'].first
    Dir.entries('bin').reject{|dir| ['.', '..'].include? dir}.each do |executable|
      next if [
        # ignored binaries
        'test'
      ].include? executable
      s.executables << executable
    end
  end

  # s.platform = Gem::Platform::RUBY # Gem::Platform::RUBY is the default, indicates a pure-Ruby gem.
  s.required_ruby_version = '>= 1.8.2'


  # Sign gem #############################################################
  s.cert_chain = ['certs/doga.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
end
