# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polyamorous}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ernie Miller"]
  s.date = %q{2011-09-03 00:00:00.000000000Z}
  s.description = %q{
    This is just an extraction from Ransack/Squeel. You probably don't want to use this
    directly. It extends ActiveRecord's associations to support polymorphic belongs_to
    associations.
  }
  s.email = ["ernie@metautonomo.us"]
  s.files = [".gitignore", "Gemfile", "LICENSE", "README.md", "Rakefile", "lib/polyamorous.rb", "lib/polyamorous/join.rb", "lib/polyamorous/join_association.rb", "lib/polyamorous/join_dependency.rb", "lib/polyamorous/version.rb", "polyamorous.gemspec", "spec/blueprints/articles.rb", "spec/blueprints/comments.rb", "spec/blueprints/notes.rb", "spec/blueprints/people.rb", "spec/blueprints/tags.rb", "spec/helpers/polyamorous_helper.rb", "spec/polyamorous/join_association_spec.rb", "spec/polyamorous/join_dependency_spec.rb", "spec/polyamorous/join_spec.rb", "spec/spec_helper.rb", "spec/support/schema.rb"]
  s.homepage = %q{http://github.com/ernie/polyamorous}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{polyamorous}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Loves/is loved by polymorphic belongs_to associations, Ransack, Squeel, MetaSearch...}
  s.test_files = ["spec/blueprints/articles.rb", "spec/blueprints/comments.rb", "spec/blueprints/notes.rb", "spec/blueprints/people.rb", "spec/blueprints/tags.rb", "spec/helpers/polyamorous_helper.rb", "spec/polyamorous/join_association_spec.rb", "spec/polyamorous/join_dependency_spec.rb", "spec/polyamorous/join_spec.rb", "spec/spec_helper.rb", "spec/support/schema.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<machinist>, ["~> 1.0.6"])
      s.add_development_dependency(%q<faker>, ["~> 0.9.5"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.3"])
    else
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<machinist>, ["~> 1.0.6"])
      s.add_dependency(%q<faker>, ["~> 0.9.5"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<machinist>, ["~> 1.0.6"])
    s.add_dependency(%q<faker>, ["~> 0.9.5"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.3"])
  end
end
