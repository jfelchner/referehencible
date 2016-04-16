# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'referehencible/version'

Gem::Specification.new do |spec|
  spec.name          = 'referehencible'
  spec.version       = Referehencible::VERSION
  spec.authors       = ['jfelchner']
  spec.email         = 'accounts+git@thekompanee.com'
  spec.summary       = %q{Enable unique reference numbers on all the things}
  spec.description   = %q{}
  spec.homepage      = 'https://github.com/chirrpy/referehencible'
  spec.license       = 'MIT'

  spec.executables   = []
  spec.files         = Dir['{app,config,db,lib}/**/*'] + %w{Rakefile README.md LICENSE.txt}
  spec.test_files    = Dir['{test,spec,features}/**/*']


  spec.add_development_dependency 'rspec', ["~> 3.0"]
  spec.add_development_dependency 'rspectacular', ["~> 0.45.0"]
end
