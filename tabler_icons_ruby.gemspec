# frozen_string_literal: true

require_relative "lib/tabler_icons_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "tabler_icons_ruby"
  spec.version = TablerIconsRuby::VERSION
  spec.authors = ["Owais"]
  spec.email = ["owaiswiz@gmail.com"]

  spec.summary = "Use tabler icons using Ruby (Rails or any other framework)"
  spec.description = "A simple helper to use tabler icons using Ruby (Rails or any other framework)"
  spec.homepage = "https://github.com/owaiswiz/tabler_icons_ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/owaiswiz/tabler_icons_ruby"
  spec.metadata["changelog_uri"] = "https://github.com/owaiswiz/tabler_icons_ruby/releases"

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

  spec.add_development_dependency "nokogiri"
end
