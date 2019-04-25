
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "SocialShareFeature/version"

Gem::Specification.new do |spec|
  spec.name          = "SocialShareFeature"
  spec.version       = SocialShareFeature::VERSION
  spec.authors       = ["Avdhesh"]
  spec.email         = ["avdhesh51000@gmail.com"]

  spec.summary       = %q{Social Share on networks and shared count.}
  spec.description   = %q{Share on social media platform and check how many times url was shared in social networks, e.g. share counts.}
  spec.homepage      = "https://github.com/Avdhesh51000/SocialShareFeature"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
    spec.metadata["source_code_uri"] = "https://github.com/Avdhesh51000/#{spec.name}/releases/tag/V#{spec.version}"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  # spec.files         = Dir.glob('lib/**/*')+ %w(README.md CHANGELOG.md LICENSE.txt)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.files         = Dir.glob("{bin,lib,config,app}/**/*")+ %w(README.md CHANGELOG.md LICENSE.txt)
  spec.add_development_dependency "rails"
  spec.add_runtime_dependency "coffee-rails"
  spec.add_dependency 'rest-client'
  spec.add_dependency 'json'
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
