# frozen_string_literal: true

source "https://rubygems.org"
gemspec

rails_version = "#{ENV['RAILS_VERSION'] || '6.0.2.2'}"

gem "capybara", "~> 3"
# gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
gem "rails",  git: "https://github.com/BlakeWilliams/rails.git", branch: "blakewilliams/nested-render-patch"
