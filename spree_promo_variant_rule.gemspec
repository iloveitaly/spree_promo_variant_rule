# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_promo_variant_rule'
  s.version     = '1.0.0'
  s.summary     = 'Adds a variant selector rule to the promotion system'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Michael Bianco'
  s.email     = 'mike@cliffsidemedia.com '
  s.homepage  = 'https://github.com/iloveitaly/spree_promo_variant_rule'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.1'

  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'rspec-rails', '2.12.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'sqlite3'
end
