require_relative "lib/unsubscribe/version"

Gem::Specification.new do |spec|
  spec.name = "unsubscribe"
  spec.version = Unsubscribe::VERSION
  spec.authors = ["Steve Polito"]
  spec.email = ["stevepolito@hey.com"]
  spec.homepage = "https://github.com/stevepolitodesign/unsubscribe"
  spec.summary = "Automatically unsubscribe from emails in Rails. "
  spec.description = "Automatically unsubscribe from emails in Rails. "
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/stevepolitodesign/unsubscribe"
  spec.metadata["changelog_uri"] = "https://github.com/stevepolitodesign/unsubscribe/blob/documentation/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0.0"
end
