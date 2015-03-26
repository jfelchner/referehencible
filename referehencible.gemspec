# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'referehencible/version'

Gem::Specification.new do |s|
  s.rubygems_version      = '1.3.5'

  s.name                  = 'referehencible'
  s.rubyforge_project     = 'referehencible'

  s.version               = Referehencible::VERSION
  s.platform              = Gem::Platform::RUBY

  s.authors               = %w{jfelchner}
  s.email                 = 'accounts+git@thekompanee.com'
  s.date                  = Time.now
  s.homepage              = 'https://github.com/chirrpy/referehencible'

  s.summary               = 'Enable unique reference numbers on all the things'
  s.description           = ''

  s.rdoc_options          = ['--charset = UTF-8']
  s.extra_rdoc_files      = %w{README.md LICENSE}

  s.executables           = Dir['{bin}/**/*'].map    { |bin| File.basename(bin) }.
                                             reject { |bin| %w{rails rspec rake setup deploy}.include? bin }
  s.files                 = Dir['{app,config,db,lib,templates}/**/*'] + %w{Rakefile README.md LICENSE}
  s.test_files            = Dir['{test,spec,features}/**/*']
  s.require_paths         = ['lib']

  s.add_development_dependency 'rspec',        ['~> 3.0']
  s.add_development_dependency 'rspectacular', ['~> 0.45.0']
end
