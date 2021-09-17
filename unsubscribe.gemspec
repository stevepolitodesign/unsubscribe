require_relative "lib/unsubscribe/version"

Gem::Specification.new do |spec|
  spec.name        = "unsubscribe"
  spec.version     = Unsubscribe::VERSION
  spec.authors     = ["Steve Polito"]
  spec.email       = ["stevepolito@hey.com"]
  spec.homepage    = "https://github.com/stevepolitodesign/unsubscribe"
  spec.summary     = "Automatically unsubscribe from emails in Rails. "
  spec.description = "Automatically unsubscribe from emails in Rails. "
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "Set to 'https://rubygems.org/'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stevepolitodesign/unsubscribe"
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
end
