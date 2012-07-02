# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{formtastic}
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin French"]
  s.date = %q{2012-03-02}
  s.description = %q{A Rails form builder plugin/gem with semantically rich and accessible markup}
  s.email = ["justin@indent.com.au"]
  s.extra_rdoc_files = ["README.textile"]
  s.files = [".gitignore", ".rspec", ".travis.yml", ".yardopts", "Appraisals", "CHANGELOG", "Gemfile", "MIT-LICENSE", "README.textile", "RELEASE_PROCESS", "Rakefile", "app/assets/stylesheets/formtastic.css", "app/assets/stylesheets/formtastic_ie6.css", "app/assets/stylesheets/formtastic_ie7.css", "formtastic.gemspec", "gemfiles/rails-3.0.gemfile", "gemfiles/rails-3.1.gemfile", "gemfiles/rails-3.2.gemfile", "lib/formtastic.rb", "lib/formtastic/actions.rb", "lib/formtastic/actions/base.rb", "lib/formtastic/actions/button_action.rb", "lib/formtastic/actions/buttonish.rb", "lib/formtastic/actions/input_action.rb", "lib/formtastic/actions/link_action.rb", "lib/formtastic/engine.rb", "lib/formtastic/form_builder.rb", "lib/formtastic/helpers.rb", "lib/formtastic/helpers/action_helper.rb", "lib/formtastic/helpers/actions_helper.rb", "lib/formtastic/helpers/buttons_helper.rb", "lib/formtastic/helpers/errors_helper.rb", "lib/formtastic/helpers/fieldset_wrapper.rb", "lib/formtastic/helpers/file_column_detection.rb", "lib/formtastic/helpers/form_helper.rb", "lib/formtastic/helpers/input_helper.rb", "lib/formtastic/helpers/inputs_helper.rb", "lib/formtastic/helpers/reflection.rb", "lib/formtastic/html_attributes.rb", "lib/formtastic/i18n.rb", "lib/formtastic/inputs.rb", "lib/formtastic/inputs/base.rb", "lib/formtastic/inputs/base/associations.rb", "lib/formtastic/inputs/base/choices.rb", "lib/formtastic/inputs/base/collections.rb", "lib/formtastic/inputs/base/database.rb", "lib/formtastic/inputs/base/errors.rb", "lib/formtastic/inputs/base/fileish.rb", "lib/formtastic/inputs/base/grouped_collections.rb", "lib/formtastic/inputs/base/hints.rb", "lib/formtastic/inputs/base/html.rb", "lib/formtastic/inputs/base/labelling.rb", "lib/formtastic/inputs/base/naming.rb", "lib/formtastic/inputs/base/numeric.rb", "lib/formtastic/inputs/base/options.rb", "lib/formtastic/inputs/base/placeholder.rb", "lib/formtastic/inputs/base/stringish.rb", "lib/formtastic/inputs/base/timeish.rb", "lib/formtastic/inputs/base/validations.rb", "lib/formtastic/inputs/base/wrapping.rb", "lib/formtastic/inputs/boolean_input.rb", "lib/formtastic/inputs/check_boxes_input.rb", "lib/formtastic/inputs/country_input.rb", "lib/formtastic/inputs/date_input.rb", "lib/formtastic/inputs/datetime_input.rb", "lib/formtastic/inputs/email_input.rb", "lib/formtastic/inputs/file_input.rb", "lib/formtastic/inputs/hidden_input.rb", "lib/formtastic/inputs/number_input.rb", "lib/formtastic/inputs/password_input.rb", "lib/formtastic/inputs/phone_input.rb", "lib/formtastic/inputs/radio_input.rb", "lib/formtastic/inputs/range_input.rb", "lib/formtastic/inputs/search_input.rb", "lib/formtastic/inputs/select_input.rb", "lib/formtastic/inputs/string_input.rb", "lib/formtastic/inputs/text_input.rb", "lib/formtastic/inputs/time_input.rb", "lib/formtastic/inputs/time_zone_input.rb", "lib/formtastic/inputs/url_input.rb", "lib/formtastic/localized_string.rb", "lib/formtastic/localizer.rb", "lib/formtastic/util.rb", "lib/formtastic/version.rb", "lib/generators/formtastic/form/form_generator.rb", "lib/generators/formtastic/install/install_generator.rb", "lib/generators/templates/_form.html.erb", "lib/generators/templates/_form.html.haml", "lib/generators/templates/_form.html.slim", "lib/generators/templates/formtastic.rb", "lib/locale/en.yml", "lib/tasks/verify_rcov.rb", "sample/basic_inputs.html", "sample/config.ru", "sample/index.html", "spec/actions/button_action_spec.rb", "spec/actions/generic_action_spec.rb", "spec/actions/input_action_spec.rb", "spec/actions/link_action_spec.rb", "spec/builder/custom_builder_spec.rb", "spec/builder/error_proc_spec.rb", "spec/builder/semantic_fields_for_spec.rb", "spec/generators/formtastic/form/form_generator_spec.rb", "spec/generators/formtastic/install/install_generator_spec.rb", "spec/helpers/action_helper_spec.rb", "spec/helpers/actions_helper_spec.rb", "spec/helpers/buttons_helper_spec.rb", "spec/helpers/commit_button_helper_spec.rb", "spec/helpers/form_helper_spec.rb", "spec/helpers/input_helper_spec.rb", "spec/helpers/inputs_helper_spec.rb", "spec/helpers/reflection_helper_spec.rb", "spec/helpers/semantic_errors_helper_spec.rb", "spec/i18n_spec.rb", "spec/inputs/boolean_input_spec.rb", "spec/inputs/check_boxes_input_spec.rb", "spec/inputs/country_input_spec.rb", "spec/inputs/custom_input_spec.rb", "spec/inputs/date_input_spec.rb", "spec/inputs/datetime_input_spec.rb", "spec/inputs/email_input_spec.rb", "spec/inputs/file_input_spec.rb", "spec/inputs/hidden_input_spec.rb", "spec/inputs/include_blank_spec.rb", "spec/inputs/label_spec.rb", "spec/inputs/number_input_spec.rb", "spec/inputs/password_input_spec.rb", "spec/inputs/phone_input_spec.rb", "spec/inputs/placeholder_spec.rb", "spec/inputs/radio_input_spec.rb", "spec/inputs/range_input_spec.rb", "spec/inputs/search_input_spec.rb", "spec/inputs/select_input_spec.rb", "spec/inputs/string_input_spec.rb", "spec/inputs/text_input_spec.rb", "spec/inputs/time_input_spec.rb", "spec/inputs/time_zone_input_spec.rb", "spec/inputs/url_input_spec.rb", "spec/inputs/with_options_spec.rb", "spec/localizer_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/support/custom_macros.rb", "spec/support/deferred_garbage_collection.rb", "spec/support/deprecation.rb", "spec/support/test_environment.rb"]
  s.homepage = %q{http://github.com/justinfrench/formtastic}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A Rails form builder plugin/gem with semantically rich and accessible markup}
  s.test_files = ["spec/actions/button_action_spec.rb", "spec/actions/generic_action_spec.rb", "spec/actions/input_action_spec.rb", "spec/actions/link_action_spec.rb", "spec/builder/custom_builder_spec.rb", "spec/builder/error_proc_spec.rb", "spec/builder/semantic_fields_for_spec.rb", "spec/generators/formtastic/form/form_generator_spec.rb", "spec/generators/formtastic/install/install_generator_spec.rb", "spec/helpers/action_helper_spec.rb", "spec/helpers/actions_helper_spec.rb", "spec/helpers/buttons_helper_spec.rb", "spec/helpers/commit_button_helper_spec.rb", "spec/helpers/form_helper_spec.rb", "spec/helpers/input_helper_spec.rb", "spec/helpers/inputs_helper_spec.rb", "spec/helpers/reflection_helper_spec.rb", "spec/helpers/semantic_errors_helper_spec.rb", "spec/i18n_spec.rb", "spec/inputs/boolean_input_spec.rb", "spec/inputs/check_boxes_input_spec.rb", "spec/inputs/country_input_spec.rb", "spec/inputs/custom_input_spec.rb", "spec/inputs/date_input_spec.rb", "spec/inputs/datetime_input_spec.rb", "spec/inputs/email_input_spec.rb", "spec/inputs/file_input_spec.rb", "spec/inputs/hidden_input_spec.rb", "spec/inputs/include_blank_spec.rb", "spec/inputs/label_spec.rb", "spec/inputs/number_input_spec.rb", "spec/inputs/password_input_spec.rb", "spec/inputs/phone_input_spec.rb", "spec/inputs/placeholder_spec.rb", "spec/inputs/radio_input_spec.rb", "spec/inputs/range_input_spec.rb", "spec/inputs/search_input_spec.rb", "spec/inputs/select_input_spec.rb", "spec/inputs/string_input_spec.rb", "spec/inputs/text_input_spec.rb", "spec/inputs/time_input_spec.rb", "spec/inputs/time_zone_input_spec.rb", "spec/inputs/url_input_spec.rb", "spec/inputs/with_options_spec.rb", "spec/localizer_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "spec/support/custom_macros.rb", "spec/support/deferred_garbage_collection.rb", "spec/support/deprecation.rb", "spec/support/test_environment.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
      s.add_development_dependency(%q<hpricot>, ["~> 0.8.3"])
      s.add_development_dependency(%q<BlueCloth>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_development_dependency(%q<colored>, [">= 0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<ammeter>, ["~> 0.2.2"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.8.0"])
      s.add_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
      s.add_dependency(%q<hpricot>, ["~> 0.8.3"])
      s.add_dependency(%q<BlueCloth>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.6"])
      s.add_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_dependency(%q<colored>, [">= 0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<ammeter>, ["~> 0.2.2"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.8.0"])
    s.add_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
    s.add_dependency(%q<hpricot>, ["~> 0.8.3"])
    s.add_dependency(%q<BlueCloth>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.6"])
    s.add_dependency(%q<rcov>, ["~> 0.9.9"])
    s.add_dependency(%q<colored>, [">= 0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<ammeter>, ["~> 0.2.2"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
