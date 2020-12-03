$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "cloud_model/api/hetzner/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "cloudmodel-api-hetzner"
  spec.version     = CloudModel::Api::Hetzner::VERSION
  spec.authors     = ["Sven G. Broenstrup (StarPeak)"]
  spec.email       = ["info@cloud-model.org"]
  spec.homepage    = "http://cloud-model.org/"
  spec.licenses    = ['MIT']
  spec.summary     = "Hetzner Hosting API support for CloudModel"
  spec.description = "Support for Hetzner Hosting API in CloudModel."


  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"
  spec.add_dependency 'cloudmodel', '~> 0.2.1'
end
