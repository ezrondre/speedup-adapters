$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
# require "speed_up_rails_adapters/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "speedup-adapters"
  s.version     = "0.0.8"
  s.authors     = ["Ondřej Ezr"]
  s.email       = ["ezrondre@fit.cvut.cz"]
  s.homepage    = "https://github.com/ezrondre/speedup-rails"
  s.summary     = "SpeedUpRails adapters are support gem for SpeedUpRails gem providing methods to store request informations."
  s.description = "SpeedUpRails is written in hope it will help develop faster rails applications."
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "MIT-LICENSE", "README.rdoc"]
  # s.test_files = Dir["spec/**/*"]

  s.add_dependency 'httpclient'
  s.add_dependency 'influxdb'

  s.add_development_dependency 'rspec', '~> 3.0'

end
