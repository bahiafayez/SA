# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kaminari}
  s.version = "0.13.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Akira Matsuda"]
  s.date = %q{2011-12-22}
  s.description = %q{Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 3}
  s.email = ["ronnie@dio.jp"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = [".document", ".gemtest", ".gitignore", ".rspec", ".travis.yml", "CHANGELOG", "Gemfile", "MIT-LICENSE", "README.rdoc", "Rakefile", "app/views/kaminari/_first_page.html.erb", "app/views/kaminari/_first_page.html.haml", "app/views/kaminari/_first_page.html.slim", "app/views/kaminari/_gap.html.erb", "app/views/kaminari/_gap.html.haml", "app/views/kaminari/_gap.html.slim", "app/views/kaminari/_last_page.html.erb", "app/views/kaminari/_last_page.html.haml", "app/views/kaminari/_last_page.html.slim", "app/views/kaminari/_next_page.html.erb", "app/views/kaminari/_next_page.html.haml", "app/views/kaminari/_next_page.html.slim", "app/views/kaminari/_page.html.erb", "app/views/kaminari/_page.html.haml", "app/views/kaminari/_page.html.slim", "app/views/kaminari/_paginator.html.erb", "app/views/kaminari/_paginator.html.haml", "app/views/kaminari/_paginator.html.slim", "app/views/kaminari/_prev_page.html.erb", "app/views/kaminari/_prev_page.html.haml", "app/views/kaminari/_prev_page.html.slim", "config/locales/kaminari.yml", "kaminari.gemspec", "lib/generators/kaminari/config_generator.rb", "lib/generators/kaminari/templates/kaminari_config.rb", "lib/generators/kaminari/views_generator.rb", "lib/kaminari.rb", "lib/kaminari/config.rb", "lib/kaminari/engine.rb", "lib/kaminari/helpers/action_view_extension.rb", "lib/kaminari/helpers/paginator.rb", "lib/kaminari/helpers/sinatra_helpers.rb", "lib/kaminari/helpers/tags.rb", "lib/kaminari/hooks.rb", "lib/kaminari/models/active_record_extension.rb", "lib/kaminari/models/active_record_model_extension.rb", "lib/kaminari/models/active_record_relation_methods.rb", "lib/kaminari/models/array_extension.rb", "lib/kaminari/models/configuration_methods.rb", "lib/kaminari/models/data_mapper_collection_methods.rb", "lib/kaminari/models/data_mapper_extension.rb", "lib/kaminari/models/mongo_mapper_extension.rb", "lib/kaminari/models/mongoid_criteria_methods.rb", "lib/kaminari/models/mongoid_extension.rb", "lib/kaminari/models/page_scope_methods.rb", "lib/kaminari/models/plucky_criteria_methods.rb", "lib/kaminari/railtie.rb", "lib/kaminari/sinatra.rb", "lib/kaminari/version.rb", "spec/config/config_spec.rb", "spec/fake_app.rb", "spec/fake_gem.rb", "spec/helpers/action_view_extension_spec.rb", "spec/helpers/helpers_spec.rb", "spec/helpers/sinatra_helpers_spec.rb", "spec/helpers/tags_spec.rb", "spec/models/active_record_relation_methods_spec.rb", "spec/models/array_spec.rb", "spec/models/data_mapper_spec.rb", "spec/models/default_per_page_spec.rb", "spec/models/mongo_mapper_spec.rb", "spec/models/mongoid_spec.rb", "spec/models/scopes_spec.rb", "spec/requests/users_spec.rb", "spec/spec_helper.rb", "spec/spec_helper_for_sinatra.rb", "spec/support/database_cleaner.rb", "spec/support/matchers.rb"]
  s.homepage = %q{https://github.com/amatsuda/kaminari}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{kaminari}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A pagination engine plugin for Rails 3 or other modern frameworks}
  s.test_files = ["spec/config/config_spec.rb", "spec/fake_app.rb", "spec/fake_gem.rb", "spec/helpers/action_view_extension_spec.rb", "spec/helpers/helpers_spec.rb", "spec/helpers/sinatra_helpers_spec.rb", "spec/helpers/tags_spec.rb", "spec/models/active_record_relation_methods_spec.rb", "spec/models/array_spec.rb", "spec/models/data_mapper_spec.rb", "spec/models/default_per_page_spec.rb", "spec/models/mongo_mapper_spec.rb", "spec/models/mongoid_spec.rb", "spec/models/scopes_spec.rb", "spec/requests/users_spec.rb", "spec/spec_helper.rb", "spec/spec_helper_for_sinatra.rb", "spec/support/database_cleaner.rb", "spec/support/matchers.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.0.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_development_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_development_dependency(%q<sinatra>, [">= 1.3"])
      s.add_development_dependency(%q<mongoid>, [">= 2"])
      s.add_development_dependency(%q<mongo_mapper>, [">= 0.9"])
      s.add_development_dependency(%q<dm-core>, [">= 1.1.0"])
      s.add_development_dependency(%q<dm-migrations>, [">= 1.1.0"])
      s.add_development_dependency(%q<dm-aggregates>, [">= 1.1.0"])
      s.add_development_dependency(%q<dm-sqlite-adapter>, [">= 1.1.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 1.0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<padrino-helpers>, ["~> 0.10"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<sinatra-contrib>, ["~> 1.3"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_dependency(%q<railties>, [">= 3.0.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<activemodel>, [">= 3.0.0"])
      s.add_dependency(%q<sinatra>, [">= 1.3"])
      s.add_dependency(%q<mongoid>, [">= 2"])
      s.add_dependency(%q<mongo_mapper>, [">= 0.9"])
      s.add_dependency(%q<dm-core>, [">= 1.1.0"])
      s.add_dependency(%q<dm-migrations>, [">= 1.1.0"])
      s.add_dependency(%q<dm-aggregates>, [">= 1.1.0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 1.1.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 1.0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<padrino-helpers>, ["~> 0.10"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<sinatra-contrib>, ["~> 1.3"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<actionpack>, [">= 3.0.0"])
    s.add_dependency(%q<railties>, [">= 3.0.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<activemodel>, [">= 3.0.0"])
    s.add_dependency(%q<sinatra>, [">= 1.3"])
    s.add_dependency(%q<mongoid>, [">= 2"])
    s.add_dependency(%q<mongo_mapper>, [">= 0.9"])
    s.add_dependency(%q<dm-core>, [">= 1.1.0"])
    s.add_dependency(%q<dm-migrations>, [">= 1.1.0"])
    s.add_dependency(%q<dm-aggregates>, [">= 1.1.0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 1.1.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 1.0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<padrino-helpers>, ["~> 0.10"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<sinatra-contrib>, ["~> 1.3"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
