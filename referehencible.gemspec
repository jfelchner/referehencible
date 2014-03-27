# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'referehencible/version'

Gem::Specification.new do |s|
  s.rubygems_version      = '1.3.5'

  s.name                  = 'referehencible'
  s.rubyforge_project     = 'referehencible'

  s.version               = Referehencible::VERSION
  s.platform              = Gem::Platform::RUBY

  s.authors               = %w{jfelchner m5rk}
  s.email                 = 'support@chirrpy.com'
  s.date                  = Date.today
  s.homepage              = 'https://github.com/chirrpy/referehencible'

  s.summary               = %q{Enable unique reference numbers on all the things}
  s.description           = %q{}

  s.rdoc_options          = ["--charset = UTF-8"]
  s.extra_rdoc_files      = %w[README.md LICENSE]

  s.executables           = Dir["{bin}/**/*"]
  s.files                 = Dir["{app,config,db,lib}/**/*"] + %w{Rakefile README.md}
  s.test_files            = Dir["{test,spec,features}/**/*"]
  s.require_paths         = ['lib']

  s.add_development_dependency 'rspec',                     '~> 3.0.beta'
  s.add_development_dependency 'rspectacular',              '~> 0.21.6'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.3.0'
end
