# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-record_invocation'
  s.summary = "Record method invocations, query the invocations, and use predicates to verify a method's invocation"
  s.version = '2.0.1.0'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/record-invocation'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'

  s.add_dependency 'evt-invocation'

  s.add_development_dependency 'test_bench'
end
