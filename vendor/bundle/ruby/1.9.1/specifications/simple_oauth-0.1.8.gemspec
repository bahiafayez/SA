# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simple_oauth}
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve Richert", "Erik Michaels-Ober"]
  s.date = %q{2012-05-09}
  s.description = %q{Simply builds and verifies OAuth headers}
  s.email = ["steve.richert@gmail.com", "sferik@gmail.com"]
  s.files = [".gemtest", ".gitignore", ".travis.yml", ".yardopts", "Gemfile", "LICENSE", "README.md", "Rakefile", "lib/simple_oauth.rb", "lib/simple_oauth/header.rb", "simple_oauth.gemspec", "spec/simple_oauth/header_spec.rb", "spec/spec_helper.rb", "spec/support/fixtures/rsa-private-key", "spec/support/rsa.rb"]
  s.homepage = %q{https://github.com/laserlemon/simple_oauth}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Simply builds and verifies OAuth headers}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end
