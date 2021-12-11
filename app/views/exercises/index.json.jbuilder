# frozen_string_literal: true

json.exercises do
  json.array! exercises do |exercise|
    json.partial! 'exercises/exercise', exercise: exercise
  end
end
json.total_pages total_pages
