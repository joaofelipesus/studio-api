# frozen_string_literal: true

json.exercises do
  json.array! exercises do |exercise|
    # rubocop:disable Style/HashSyntax
    json.partial! 'exercises/exercise', exercise: exercise
    # rubocop:enable Style/HashSyntax
  end
end
json.total_pages total_pages
json.current_page current_page
