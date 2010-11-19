Gem::Specification.new do |s|
  s.name = 'buildhawk'
  s.version = '0.2'
  s.summary = 'Display historical stats about your build'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Xavier Shay"]
  s.email       = ["contact@rhnh.net"]
  s.homepage    = "http://github.com/xaviershay/buildhawk"
  s.has_rdoc = false

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(README.rdoc HISTORY)
  s.executables  = ['buildhawk']
  s.require_path = 'lib'
  %w(json_pure erubis).each do |dep|
    s.add_dependency dep
  end
end

