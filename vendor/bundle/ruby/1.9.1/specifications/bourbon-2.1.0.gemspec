# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bourbon}
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Phil LaPier", "Chad Mazzola", "Matt Jankowski", "Nick Quaranto", "Jeremy Raines", "Mike Burns", "Andres Mejia", "Travis Haynes", "Chris Lloyd", "Gabe Berke-Williams", "J. Edward Dewyea"]
  s.date = %q{2012-05-10}
  s.default_executable = %q{bourbon}
  s.description = %q{The purpose of Bourbon Vanilla Sass Mixins is to provide a comprehensive framework of
sass mixins that are designed to be as vanilla as possible. Meaning they
should not deter from the original CSS syntax. The mixins contain vendor
specific prefixes for all CSS3 properties for support amongst modern
browsers. The prefixes also ensure graceful degradation for older browsers
that support only CSS3 prefixed properties.
}
  s.email = ["support@thoughtbot.com"]
  s.executables = ["bourbon"]
  s.files = [".gitignore", "Gemfile", "Gemfile.lock", "LICENSE", "Rakefile", "_config.yml", "_includes/animation.html", "_includes/appearance.html", "_includes/background-image.html", "_includes/background-size.html", "_includes/border-image.html", "_includes/border-radius.html", "_includes/box-shadow.html", "_includes/box-sizing.html", "_includes/buttons.html", "_includes/clearfix.html", "_includes/columns.html", "_includes/compact.html", "_includes/complete-list.html", "_includes/flex-box.html", "_includes/flex-grid.html", "_includes/font-family.html", "_includes/footer.html", "_includes/golden-ratio.html", "_includes/grid-width.html", "_includes/hide-text.html", "_includes/html5-input-types.html", "_includes/inline-block.html", "_includes/intro.html", "_includes/linear-gradient-function.html", "_includes/linear-gradient.html", "_includes/modular-scale.html", "_includes/navigation.html", "_includes/position.html", "_includes/radial-gradient-function.html", "_includes/radial-gradient.html", "_includes/timing-functions.html", "_includes/tint-shade.html", "_includes/transform-origin.html", "_includes/transform.html", "_includes/transitions.html", "_includes/user-select.html", "_site/images/border.png", "_site/images/bourbon-logo.png", "_site/index.html", "_site/stylesheets/style.css", "app/assets/stylesheets/_bourbon.scss", "app/assets/stylesheets/addons/_button.scss", "app/assets/stylesheets/addons/_clearfix.scss", "app/assets/stylesheets/addons/_font-face.scss", "app/assets/stylesheets/addons/_font-family.scss", "app/assets/stylesheets/addons/_hide-text.scss", "app/assets/stylesheets/addons/_html5-input-types.scss", "app/assets/stylesheets/addons/_position.scss", "app/assets/stylesheets/addons/_timing-functions.scss", "app/assets/stylesheets/css3/_animation.scss", "app/assets/stylesheets/css3/_appearance.scss", "app/assets/stylesheets/css3/_background-image.scss", "app/assets/stylesheets/css3/_background-size.scss", "app/assets/stylesheets/css3/_border-image.scss", "app/assets/stylesheets/css3/_border-radius.scss", "app/assets/stylesheets/css3/_box-shadow.scss", "app/assets/stylesheets/css3/_box-sizing.scss", "app/assets/stylesheets/css3/_columns.scss", "app/assets/stylesheets/css3/_flex-box.scss", "app/assets/stylesheets/css3/_inline-block.scss", "app/assets/stylesheets/css3/_linear-gradient.scss", "app/assets/stylesheets/css3/_prefixer.scss", "app/assets/stylesheets/css3/_radial-gradient.scss", "app/assets/stylesheets/css3/_transform.scss", "app/assets/stylesheets/css3/_transition.scss", "app/assets/stylesheets/css3/_user-select.scss", "app/assets/stylesheets/functions/_deprecated-webkit-gradient.scss", "app/assets/stylesheets/functions/_flex-grid.scss", "app/assets/stylesheets/functions/_grid-width.scss", "app/assets/stylesheets/functions/_linear-gradient.scss", "app/assets/stylesheets/functions/_modular-scale.scss", "app/assets/stylesheets/functions/_radial-gradient.scss", "app/assets/stylesheets/functions/_render-gradients.scss", "app/assets/stylesheets/functions/_tint-shade.scss", "app/assets/stylesheets/functions/_transition-property-name.scss", "bin/bourbon", "bourbon.gemspec", "doc/README.md", "features/install.feature", "features/step_definitions/bourbon_steps.rb", "features/support/bourbon_support.rb", "features/support/env.rb", "features/update.feature", "images/border.png", "images/bourbon-logo.png", "index.html", "lib/bourbon.rb", "lib/bourbon/engine.rb", "lib/bourbon/generator.rb", "lib/bourbon/sass_extensions.rb", "lib/bourbon/sass_extensions/functions.rb", "lib/bourbon/sass_extensions/functions/compact.rb", "lib/bourbon/version.rb", "lib/tasks/install.rake", "readme.md", "stylesheets/sass/_animation-keyframes.scss", "stylesheets/sass/_base.scss", "stylesheets/sass/_demos.scss", "stylesheets/sass/_mixins.scss", "stylesheets/sass/_normalize.scss", "stylesheets/sass/_pygments-theme-dark.scss", "stylesheets/sass/_pygments-theme-light.scss", "stylesheets/sass/style.scss", "stylesheets/style.css"]
  s.homepage = %q{https://github.com/thoughtbot/bourbon}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bourbon}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Bourbon Sass Mixins using SCSS syntax.}
  s.test_files = ["features/install.feature", "features/step_definitions/bourbon_steps.rb", "features/support/bourbon_support.rb", "features/support/env.rb", "features/update.feature"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sass>, [">= 3.1"])
      s.add_development_dependency(%q<aruba>, ["~> 0.4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<sass>, [">= 3.1"])
      s.add_dependency(%q<aruba>, ["~> 0.4"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<sass>, [">= 3.1"])
    s.add_dependency(%q<aruba>, ["~> 0.4"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
