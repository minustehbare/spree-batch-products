Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_batch_products'
  s.version     = '0.50.0'
  s.summary     = 'Updating collections of Variants/Products through use of an excel format spreadsheet'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'minustehbare'
  s.email             = 'minustehbare@gmail.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.50.0')
  s.add_dependency('spreadsheet', '>= 0.6.5.4')
end
