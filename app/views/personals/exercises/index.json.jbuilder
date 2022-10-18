# frozen_string_literal: true

json.exercises do
  json.array! paginated_data[:exercises] do |exercise|
    # rubocop:disable Style/HashSyntax
    json.partial! 'exercises/exercise', exercise: exercise
    # rubocop:enable Style/HashSyntax
  end
end
json.total_pages paginated_data[:meta][:total_pages]
json.current_page paginated_data[:meta][:current_page]
