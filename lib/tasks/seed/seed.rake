# frozen_string_literal: true

namespace :seed do
  desc 'Create default exercises'
  task complete: :environment do |task, args|
    Rake::Task["seed:personal"].invoke
  end
end
