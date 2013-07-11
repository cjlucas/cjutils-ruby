$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

Gem::Specification.new do |s|
  s.name        = 'cjutils'
  s.version     = '0.0.1'
  s.summary     = 'A collection of utilities'
  #s.description = <<-EOF
    #EasyTag is an abstract interface to the TagLib audio tagging library.
    #It is designed to provide a simple and consistent API regardless
    #of file format being read.
  #EOF
  s.authors     = ['Chris Lucas']
  s.email       = ['chris@chrisjlucas.com']
  s.homepage    = 'https://github.com/cjlucas/ruby-cjutils'
  s.license     = 'MIT'
  s.files       = `git ls-files | egrep '^[^\.]'`.split(/\r?\n/)
  s.test_files  = s.files.select { |f| f.match(/^test\/.*\.rb$/) }
  s.platform    = Gem::Platform::RUBY

  s.add_development_dependency('rake')
end
