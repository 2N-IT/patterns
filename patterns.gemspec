# frozen_string_literal: true

require_relative "lib/patterns/version"

Gem::Specification.new do |spec|
  spec.name = "patterns"
  spec.version = Patterns::VERSION
  spec.authors = ["krzykamil"]
  spec.email = ["kk.pio@protonmail.com"]

  spec.summary = "2N IT Patterns for writing ruby on rails applications."
  spec.description = "Collection of base classes for stuff like services, repositories, decorators, etc."

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.homepage = "https://github.com/2N-IT/patterns"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/2N-IT/patterns"
  spec.metadata["changelog_uri"] = "https://github.com/2N-IT/patterns/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "test_bench"

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activemodel"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
