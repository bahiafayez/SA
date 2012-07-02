# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{less}
  s.version = "2.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell"]
  s.date = %q{2012-04-25}
  s.default_executable = %q{lessc}
  s.description = %q{Invoke the Less CSS compiler from Ruby}
  s.email = ["cowboyd@thefrontside.net"]
  s.executables = ["lessc"]
  s.files = [".gitignore", ".gitmodules", ".travis.yml", "Gemfile", "README.md", "Rakefile", "bin/lessc", "less.gemspec", "lib/less.rb", "lib/less/defaults.rb", "lib/less/errors.rb", "lib/less/java_script.rb", "lib/less/java_script/rhino_context.rb", "lib/less/java_script/v8_context.rb", "lib/less/loader.rb", "lib/less/parser.rb", "lib/less/version.rb", "spec/less/faulty/faulty.less", "spec/less/one/one.less", "spec/less/parser_spec.rb", "spec/less/two/two.less", "spec/spec_helper.rb", "lib/less/js/CHANGELOG", "lib/less/js/LICENSE", "lib/less/js/Makefile", "lib/less/js/README.md", "lib/less/js/benchmark/benchmark.less", "lib/less/js/benchmark/less-benchmark.js", "lib/less/js/bin/lessc", "lib/less/js/build/amd.js", "lib/less/js/build/ecma-5.js", "lib/less/js/build/header.js", "lib/less/js/build/require-rhino.js", "lib/less/js/build/require.js", "lib/less/js/dist/less-1.1.0.js", "lib/less/js/dist/less-1.1.0.min.js", "lib/less/js/dist/less-1.1.1.js", "lib/less/js/dist/less-1.1.1.min.js", "lib/less/js/dist/less-1.1.2.js", "lib/less/js/dist/less-1.1.2.min.js", "lib/less/js/dist/less-1.1.3.js", "lib/less/js/dist/less-1.1.3.min.js", "lib/less/js/dist/less-1.1.4.js", "lib/less/js/dist/less-1.1.4.min.js", "lib/less/js/dist/less-1.1.5.js", "lib/less/js/dist/less-1.1.5.min.js", "lib/less/js/dist/less-1.1.6.js", "lib/less/js/dist/less-1.1.6.min.js", "lib/less/js/dist/less-1.2.0.js", "lib/less/js/dist/less-1.2.0.min.js", "lib/less/js/dist/less-1.2.1.js", "lib/less/js/dist/less-1.2.1.min.js", "lib/less/js/dist/less-1.2.2.js", "lib/less/js/dist/less-1.2.2.min.js", "lib/less/js/dist/less-1.3.0.js", "lib/less/js/dist/less-1.3.0.min.js", "lib/less/js/dist/less-rhino-1.1.3.js", "lib/less/js/dist/less-rhino-1.1.5.js", "lib/less/js/lib/less/browser.js", "lib/less/js/lib/less/colors.js", "lib/less/js/lib/less/cssmin.js", "lib/less/js/lib/less/functions.js", "lib/less/js/lib/less/index.js", "lib/less/js/lib/less/parser.js", "lib/less/js/lib/less/rhino.js", "lib/less/js/lib/less/tree.js", "lib/less/js/lib/less/tree/alpha.js", "lib/less/js/lib/less/tree/anonymous.js", "lib/less/js/lib/less/tree/assignment.js", "lib/less/js/lib/less/tree/call.js", "lib/less/js/lib/less/tree/color.js", "lib/less/js/lib/less/tree/comment.js", "lib/less/js/lib/less/tree/condition.js", "lib/less/js/lib/less/tree/dimension.js", "lib/less/js/lib/less/tree/directive.js", "lib/less/js/lib/less/tree/element.js", "lib/less/js/lib/less/tree/expression.js", "lib/less/js/lib/less/tree/import.js", "lib/less/js/lib/less/tree/javascript.js", "lib/less/js/lib/less/tree/keyword.js", "lib/less/js/lib/less/tree/media.js", "lib/less/js/lib/less/tree/mixin.js", "lib/less/js/lib/less/tree/operation.js", "lib/less/js/lib/less/tree/paren.js", "lib/less/js/lib/less/tree/quoted.js", "lib/less/js/lib/less/tree/rule.js", "lib/less/js/lib/less/tree/ruleset.js", "lib/less/js/lib/less/tree/selector.js", "lib/less/js/lib/less/tree/url.js", "lib/less/js/lib/less/tree/value.js", "lib/less/js/lib/less/tree/variable.js", "lib/less/js/package.json", "lib/less/js/test/css/colors.css", "lib/less/js/test/css/comments.css", "lib/less/js/test/css/css-3.css", "lib/less/js/test/css/css-escapes.css", "lib/less/js/test/css/css.css", "lib/less/js/test/css/functions.css", "lib/less/js/test/css/ie-filters.css", "lib/less/js/test/css/import.css", "lib/less/js/test/css/javascript.css", "lib/less/js/test/css/lazy-eval.css", "lib/less/js/test/css/media.css", "lib/less/js/test/css/mixins-args.css", "lib/less/js/test/css/mixins-closure.css", "lib/less/js/test/css/mixins-guards.css", "lib/less/js/test/css/mixins-important.css", "lib/less/js/test/css/mixins-nested.css", "lib/less/js/test/css/mixins-pattern.css", "lib/less/js/test/css/mixins.css", "lib/less/js/test/css/operations.css", "lib/less/js/test/css/parens.css", "lib/less/js/test/css/rulesets.css", "lib/less/js/test/css/scope.css", "lib/less/js/test/css/selectors.css", "lib/less/js/test/css/strings.css", "lib/less/js/test/css/variables.css", "lib/less/js/test/css/whitespace.css", "lib/less/js/test/less-test.js", "lib/less/js/test/less/colors.less", "lib/less/js/test/less/comments.less", "lib/less/js/test/less/css-3.less", "lib/less/js/test/less/css-escapes.less", "lib/less/js/test/less/css.less", "lib/less/js/test/less/functions.less", "lib/less/js/test/less/ie-filters.less", "lib/less/js/test/less/import.less", "lib/less/js/test/less/import/import-test-a.less", "lib/less/js/test/less/import/import-test-b.less", "lib/less/js/test/less/import/import-test-c.less", "lib/less/js/test/less/import/import-test-d.css", "lib/less/js/test/less/import/import-test-e.less", "lib/less/js/test/less/javascript.less", "lib/less/js/test/less/lazy-eval.less", "lib/less/js/test/less/media.less", "lib/less/js/test/less/mixins-args.less", "lib/less/js/test/less/mixins-closure.less", "lib/less/js/test/less/mixins-guards.less", "lib/less/js/test/less/mixins-important.less", "lib/less/js/test/less/mixins-nested.less", "lib/less/js/test/less/mixins-pattern.less", "lib/less/js/test/less/mixins.less", "lib/less/js/test/less/operations.less", "lib/less/js/test/less/parens.less", "lib/less/js/test/less/rulesets.less", "lib/less/js/test/less/scope.less", "lib/less/js/test/less/selectors.less", "lib/less/js/test/less/strings.less", "lib/less/js/test/less/variables.less", "lib/less/js/test/less/whitespace.less"]
  s.homepage = %q{http://lesscss.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{less}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Leaner CSS, in your browser or Ruby (via less.js)}
  s.test_files = ["spec/less/faulty/faulty.less", "spec/less/one/one.less", "spec/less/parser_spec.rb", "spec/less/two/two.less", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commonjs>, ["~> 0.2.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
    else
      s.add_dependency(%q<commonjs>, ["~> 0.2.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<commonjs>, ["~> 0.2.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
  end
end
