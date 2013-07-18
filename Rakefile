#!/usr/bin/env rake
require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

def run_in_dummy_app(command)
  system("cd spec/dummy && #{command}")
end

task default: "spec:all"

namespace :spec do
  task all: ["db:setup", "spec"]
end

namespace "db" do
  task "setup" do
    puts "Setting up databases"
    run_in_dummy_app "rm -f db/test.sqlite3"
    run_in_dummy_app "RAILS_ENV=test rake db:schema:load"
  end
end
